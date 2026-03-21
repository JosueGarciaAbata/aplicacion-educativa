import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/content_activity_details.dart';
import 'tables/content_questions.dart';
import 'tables/contents.dart';
import 'tables/news.dart';
import 'tables/progress.dart';
import 'tables/users.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Contents,
    News,
    Progress,
    ContentActivityDetails,
    ContentQuestions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migrator) async {
          await migrator.createAll();
        },
        onUpgrade: (Migrator migrator, int from, int to) async {
          if (from < 3) {
            await migrator.createTable(contentActivityDetails);
            await migrator.createTable(contentQuestions);
          }
        },
        beforeOpen: (OpeningDetails details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<int> createUser({
    required String username,
    required String password,
    required String name,
  }) {
    return into(users).insert(
      UsersCompanion.insert(
        username: username,
        password: password,
        name: name,
        createdAt: Value(_nowAsText()),
      ),
    );
  }

  Future<User?> getUserByUsername(String username) {
    return (select(users)..where((table) => table.username.equals(username)))
        .getSingleOrNull();
  }

  Future<List<User>> getAllUsers() {
    return (select(users)..orderBy([(table) => OrderingTerm.asc(table.name)]))
        .get();
  }

  Future<void> ensureDefaultUser() async {
    const defaultUsername = 'josue';
    final existingUser = await getUserByUsername(defaultUsername);

    if (existingUser != null) {
      return;
    }

    await createUser(
      username: defaultUsername,
      password: defaultUsername,
      name: 'Josue',
    );
  }

  Future<User?> authenticateUser({
    required String username,
    required String password,
  }) {
    return (select(users)
          ..where((table) =>
              table.username.equals(username) &
              table.password.equals(password)))
        .getSingleOrNull();
  }

  Future<int> insertContent({
    required String title,
    String? description,
    required String type,
    String? resourcePath,
    String? category,
  }) {
    return into(contents).insert(
      ContentsCompanion.insert(
        title: title,
        type: type,
        description: Value(description),
        resourcePath: Value(resourcePath),
        category: Value(category),
        createdAt: Value(_nowAsText()),
      ),
    );
  }

  Future<void> ensureSampleContents() async {
    final existingContents = await getAllContents();
    if (existingContents.isNotEmpty) {
      return;
    }

    await insertContent(
      title: 'Lectura: Cuidado del agua',
      description:
          'Aprende acciones simples para cuidar el agua en tu hogar y comunidad.',
      type: 'texto',
      category: 'Ciencias',
    );

    await insertContent(
      title: 'Partes de una planta',
      description:
          'Reconoce las partes principales de una planta y su funcion basica.',
      type: 'imagen',
      category: 'Ciencias',
    );

    await insertContent(
      title: 'Repaso de sumas',
      description:
          'Practica sumas sencillas y fortalece tu calculo mental paso a paso.',
      type: 'texto',
      category: 'Matematicas',
    );

    await insertContent(
      title: 'Historia de mi comunidad',
      description:
          'Explora un ejemplo de relato corto sobre costumbres y memoria local.',
      type: 'multimedia',
      category: 'Lengua',
    );
  }

  Future<void> ensureSampleActivityData() async {
    final contents = await getAllContents();
    for (final content in contents) {
      final existingDetail = await getActivityDetailsForContent(content.id);
      if (existingDetail != null) {
        continue;
      }

      await _seedActivityDataForContent(content);
    }
  }

  Future<List<Content>> getAllContents() {
    return (select(contents)
          ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
        .get();
  }

  Future<List<Content>> getContentsByCategory(String category) {
    return (select(contents)
          ..where((table) => table.category.equals(category))
          ..orderBy([(table) => OrderingTerm.asc(table.title)]))
        .get();
  }

  Future<Map<int, ContentActivityDetail>> getActivityDetailsMap() async {
    final mappedRows = await select(contentActivityDetails).get();

    return {
      for (final row in mappedRows) row.contentId: row,
    };
  }

  Future<ContentActivityDetail?> getActivityDetailsForContent(
    int contentId,
  ) async {
    return (select(contentActivityDetails)
          ..where((table) => table.contentId.equals(contentId)))
        .getSingleOrNull();
  }

  Future<List<ContentQuestion>> getQuestionsForContent(int contentId) async {
    return (select(contentQuestions)
          ..where((table) => table.contentId.equals(contentId))
          ..orderBy([(table) => OrderingTerm.asc(table.sortOrder)]))
        .get();
  }

  Future<int> insertNewsItem({
    required String title,
    required String body,
    String? imagePath,
    String? publishedAt,
  }) {
    return into(news).insert(
      NewsCompanion.insert(
        title: title,
        body: body,
        imagePath: Value(imagePath),
        publishedAt: Value(publishedAt ?? _nowAsText()),
      ),
    );
  }

  Future<List<New>> getAllNews() {
    return (select(news)
          ..orderBy([(table) => OrderingTerm.desc(table.publishedAt)]))
        .get();
  }

  Future<int> saveProgress({
    required int userId,
    required int contentId,
    required String status,
    String? completedAt,
  }) async {
    final existing = await (select(progress)
          ..where((table) =>
              table.userId.equals(userId) &
              table.contentId.equals(contentId)))
        .getSingleOrNull();

    if (existing == null) {
      return into(progress).insert(
        ProgressCompanion.insert(
          userId: userId,
          contentId: contentId,
          status: status,
          completedAt: Value(completedAt),
        ),
      );
    }

    return (update(progress)..where((table) => table.id.equals(existing.id)))
        .write(
      ProgressCompanion(
        status: Value(status),
        completedAt: Value(completedAt),
      ),
    );
  }

  Future<List<ProgressData>> getProgressForUser(int userId) {
    return (select(progress)
          ..where((table) => table.userId.equals(userId))
          ..orderBy([(table) => OrderingTerm.desc(table.id)]))
        .get();
  }

  Future<bool> isContentCompleted({
    required int userId,
    required int contentId,
  }) async {
    final progressEntry = await (select(progress)
          ..where((table) =>
              table.userId.equals(userId) &
              table.contentId.equals(contentId) &
              table.status.equals('completed')))
        .getSingleOrNull();

    return progressEntry != null;
  }

  Future<User?> getSessionUser(String username) {
    return (select(users)..where((table) => table.username.equals(username)))
        .getSingleOrNull();
  }

  Future<int> markContentAsCompleted({
    required int userId,
    required int contentId,
  }) {
    return saveProgress(
      userId: userId,
      contentId: contentId,
      status: 'completed',
      completedAt: _nowAsText(),
    );
  }

  String _nowAsText() => DateTime.now().toIso8601String();

  Future<void> _seedActivityDataForContent(Content content) async {
    final seed = _activitySeedFor(content);

    await into(contentActivityDetails).insert(
      ContentActivityDetailsCompanion(
        contentId: Value(content.id),
        subjectLabel: Value(seed.subjectLabel),
        activityLabel: Value(seed.activityLabel),
        ctaLabel: Value(seed.ctaLabel),
        difficulty: Value(seed.difficulty),
        questionCount: Value(seed.questions.length),
        estimatedMinutes: Value(seed.estimatedMinutes),
        learningGoals: Value(jsonEncode(seed.learningGoals)),
      ),
    );

    for (var index = 0; index < seed.questions.length; index++) {
      final question = seed.questions[index];
      await into(contentQuestions).insert(
        ContentQuestionsCompanion(
          contentId: Value(content.id),
          sortOrder: Value(index),
          typeLabel: Value(question.typeLabel),
          prompt: Value(question.prompt),
          optionsText: Value(jsonEncode(question.options)),
          correctIndex: Value(question.correctIndex),
        ),
      );
    }
  }

  _SeededActivityData _activitySeedFor(Content content) {
    final category = (content.category ?? '').trim().toLowerCase();

    if (category.contains('lengua') || category.contains('literatura')) {
      return _SeededActivityData(
        subjectLabel: 'Lengua',
        activityLabel: 'Comprension lectora',
        ctaLabel: 'Iniciar actividad',
        difficulty: 'Basico',
        estimatedMinutes: 7,
        learningGoals: const [
          'Reconocer la idea principal',
          'Relacionar palabras y significados',
          'Responder preguntas sobre el texto',
        ],
        questions: [
          _SeedQuestion(
            typeLabel: 'Idea principal',
            prompt: 'La idea principal de "${content.title}" es:',
            options: const [
              'Entender de que trata el texto',
              'Resolver una operacion matematica',
              'Medir objetos de la escuela',
            ],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Si o no',
            prompt: 'El contenido busca ayudar a comprender mejor un texto.',
            options: ['Si', 'No'],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Opcion multiple',
            prompt: 'Despues de leer, lo mejor es:',
            options: [
              'Responder preguntas sobre el texto',
              'Cerrar la actividad sin revisar',
              'Ignorar el titulo',
            ],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Relacion',
            prompt: 'Que accion ayuda a encontrar significado?',
            options: [
              'Relacionar palabras con sus ideas',
              'Borrar el texto',
              'Saltar todas las preguntas',
            ],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Comprension',
            prompt: 'Leer con atencion permite:',
            options: [
              'Entender mejor el mensaje',
              'Terminar mas lento sin aprender',
              'Evitar cualquier respuesta',
            ],
            correctIndex: 0,
          ),
        ],
      );
    }

    if (category.contains('mat')) {
      return const _SeededActivityData(
        subjectLabel: 'Matematicas',
        activityLabel: 'Resolver ejercicios',
        ctaLabel: 'Resolver ejercicios',
        difficulty: 'Basico',
        estimatedMinutes: 8,
        learningGoals: [
          'Practicar operaciones sencillas',
          'Completar resultados',
          'Resolver problemas cortos',
        ],
        questions: [
          _SeedQuestion(
            typeLabel: 'Suma',
            prompt: 'Si 4 + 3 = ?',
            options: ['7', '6', '8'],
            correctIndex: 0,
          ),
          _SeedQuestion(
            typeLabel: 'Resta',
            prompt: 'Si 9 - 5 = ?',
            options: ['3', '4', '5'],
            correctIndex: 1,
          ),
          _SeedQuestion(
            typeLabel: 'Completar resultado',
            prompt: '6 + __ = 10',
            options: ['2', '4', '5'],
            correctIndex: 1,
          ),
          _SeedQuestion(
            typeLabel: 'Problema corto',
            prompt: 'Ana tenia 2 cuadernos y recibio 3 mas. Ahora tiene:',
            options: ['4', '5', '6'],
            correctIndex: 1,
          ),
          _SeedQuestion(
            typeLabel: 'Serie simple',
            prompt: 'Completa la serie: 2, 4, 6, __',
            options: ['7', '8', '9'],
            correctIndex: 1,
          ),
          _SeedQuestion(
            typeLabel: 'Calculo mental',
            prompt: '5 + 5 = ?',
            options: ['10', '9', '11'],
            correctIndex: 0,
          ),
        ],
      );
    }

    if (category.contains('ciencia')) {
      return _SeededActivityData(
        subjectLabel: 'Ciencias',
        activityLabel: 'Explorar conceptos',
        ctaLabel: 'Explorar actividad',
        difficulty: 'Basico',
        estimatedMinutes: 6,
        learningGoals: const [
          'Identificar conceptos clave',
          'Relacionar imagen y nombre',
          'Clasificar elementos simples',
        ],
        questions: [
          _SeedQuestion(
            typeLabel: 'Verdadero o falso',
            prompt:
                '"${content.title}" se relaciona con el estudio del entorno natural.',
            options: const ['Verdadero', 'Falso'],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Conceptos basicos',
            prompt: 'En ciencias es importante observar, comparar y explicar.',
            options: ['Si', 'No'],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Identificar partes',
            prompt: 'Una planta tiene partes como raiz, tallo y hojas.',
            options: ['Correcto', 'Incorrecto'],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Relacion',
            prompt: 'Que ayuda a reconocer mejor un ser vivo?',
            options: [
              'Observar sus partes y funciones',
              'Adivinar sin mirar',
              'Ignorar la imagen',
            ],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Clasificacion',
            prompt: 'Clasificar sirve para:',
            options: [
              'Ordenar segun caracteristicas',
              'Confundir conceptos',
              'Quitar informacion',
            ],
            correctIndex: 0,
          ),
        ],
      );
    }

    if (category.contains('social') || category.contains('comunidad')) {
      return _SeededActivityData(
        subjectLabel: 'Sociales',
        activityLabel: 'Comprender y ordenar',
        ctaLabel: 'Iniciar actividad',
        difficulty: 'Basico',
        estimatedMinutes: 6,
        learningGoals: const [
          'Comprender hechos y costumbres',
          'Ordenar eventos sencillos',
          'Relacionar texto y contexto local',
        ],
        questions: [
          _SeedQuestion(
            typeLabel: 'Comprension',
            prompt:
                'El contenido "${content.title}" busca conocer mejor hechos o costumbres.',
            options: const ['Si', 'No'],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Secuencia',
            prompt:
                'Para entender una historia local conviene revisar los hechos en orden.',
            options: ['Correcto', 'Incorrecto'],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Contexto',
            prompt:
                'La comunidad se entiende mejor cuando observamos sus tradiciones.',
            options: ['Si', 'No'],
            correctIndex: 0,
          ),
          const _SeedQuestion(
            typeLabel: 'Costumbres',
            prompt: 'Que ayuda a conocer una costumbre?',
            options: [
              'Escuchar relatos y observar practicas',
              'Ignorar a las personas',
              'Cambiar el tema',
            ],
            correctIndex: 0,
          ),
        ],
      );
    }

    return _SeededActivityData(
      subjectLabel: 'Aprendizaje',
      activityLabel: 'Actividad guiada',
      ctaLabel: 'Iniciar actividad',
      difficulty: 'Basico',
      estimatedMinutes: 5,
      learningGoals: const [
        'Leer el contenido principal',
        'Responder preguntas sencillas',
        'Reforzar lo aprendido',
      ],
      questions: [
        _SeedQuestion(
          typeLabel: 'Comprension',
          prompt: 'El contenido "${content.title}" se puede aprender paso a paso.',
          options: const ['Si', 'No'],
          correctIndex: 0,
        ),
        const _SeedQuestion(
          typeLabel: 'Opcion multiple',
          prompt: 'Para aprender mejor conviene:',
          options: [
            'Leer y responder preguntas',
            'Cerrar la actividad rapido',
            'No revisar nada',
          ],
          correctIndex: 0,
        ),
        const _SeedQuestion(
          typeLabel: 'Refuerzo',
          prompt: 'Practicar ayuda a recordar mejor lo aprendido.',
          options: ['Verdadero', 'Falso'],
          correctIndex: 0,
        ),
        const _SeedQuestion(
          typeLabel: 'Aplicacion',
          prompt: 'Una actividad guiada sirve para:',
          options: [
            'Reforzar conocimientos',
            'Evitar estudiar',
            'Borrar informacion',
          ],
          correctIndex: 0,
        ),
      ],
    );
  }
}

class _SeededActivityData {
  const _SeededActivityData({
    required this.subjectLabel,
    required this.activityLabel,
    required this.ctaLabel,
    required this.difficulty,
    required this.estimatedMinutes,
    required this.learningGoals,
    required this.questions,
  });

  final String subjectLabel;
  final String activityLabel;
  final String ctaLabel;
  final String difficulty;
  final int estimatedMinutes;
  final List<String> learningGoals;
  final List<_SeedQuestion> questions;
}

class _SeedQuestion {
  const _SeedQuestion({
    required this.typeLabel,
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });

  final String typeLabel;
  final String prompt;
  final List<String> options;
  final int correctIndex;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'aplicacion_educativa.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
