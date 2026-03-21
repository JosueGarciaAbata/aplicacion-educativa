import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/contents.dart';
import 'tables/news.dart';
import 'tables/progress.dart';
import 'tables/users.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, Contents, News, Progress])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migrator) async {
          await migrator.createAll();
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'aplicacion_educativa.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
