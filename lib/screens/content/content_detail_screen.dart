import 'package:aplicacion_educativa/data/database.dart';
import 'package:aplicacion_educativa/screens/content/content_activity_screen.dart';
import 'package:aplicacion_educativa/screens/content/content_activity_support.dart';
import 'package:aplicacion_educativa/screens/content/widgets/content_resource_view.dart';
import 'package:flutter/material.dart';

class ContentDetailScreen extends StatefulWidget {
  const ContentDetailScreen({
    super.key,
    required this.content,
    required this.userId,
  });

  final Content content;
  final int userId;

  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {
  bool _isCompleted = false;
  bool _isLoading = true;
  bool _isSaving = false;
  ContentActivityDetail? _activityDetails;
  List<ContentQuestion> _questions = const [];

  @override
  void initState() {
    super.initState();
    _loadCompletionState();
  }

  Future<void> _loadCompletionState() async {
    final completed = await appDatabase.isContentCompleted(
      userId: widget.userId,
      contentId: widget.content.id,
    );
    final activityDetails = await appDatabase.getActivityDetailsForContent(
      widget.content.id,
    );
    final questions = await appDatabase.getQuestionsForContent(widget.content.id);

    if (!mounted) {
      return;
    }

    setState(() {
      _isCompleted = completed;
      _activityDetails = activityDetails;
      _questions = questions;
      _isLoading = false;
    });
  }

  Future<void> _markAsCompleted() async {
    if (_isCompleted || _isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    await appDatabase.markContentAsCompleted(
      userId: widget.userId,
      contentId: widget.content.id,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isCompleted = true;
      _isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contenido marcado como completado.'),
      ),
    );
  }

  Future<void> _openActivity() async {
    final completed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => ContentActivityScreen(
          content: widget.content,
          userId: widget.userId,
        ),
      ),
    );

    if (completed == true) {
      await _loadCompletionState();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF6F1E8),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    final metadata = buildActivityMetadata(
      content: widget.content,
      details: _activityDetails,
      isCompleted: _isCompleted,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1E8),
      appBar: AppBar(
        title: const Text('Actividad educativa'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: _openActivity,
                style: FilledButton.styleFrom(
                  backgroundColor: metadata.palette.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: const Icon(Icons.play_circle_outline_rounded),
                label: Text(metadata.ctaLabel),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: (_isCompleted || _isSaving) ? null : _markAsCompleted,
                icon: Icon(
                  _isCompleted
                      ? Icons.check_circle_outline
                      : Icons.task_alt_outlined,
                ),
                label: Text(
                  _isCompleted
                      ? 'Ya completaste esta actividad'
                      : (_isSaving
                            ? 'Guardando avance...'
                            : 'Marcar como completado'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeroBlock(
              content: widget.content,
              isCompleted: _isCompleted,
              metadata: metadata,
            ),
            const SizedBox(height: 18),
            _SummaryGrid(metadata: metadata),
            const SizedBox(height: 18),
            _SectionCard(
              title: 'Lo que vas a aprender',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final goal in metadata.learningGoals) ...[
                    _LearningGoalRow(
                      text: goal,
                      color: metadata.palette.primary,
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 18),
            _SectionCard(
              title: 'Recurso principal',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ContentResourceView(
                    content: widget.content,
                    height: 220,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.content.description?.trim().isNotEmpty == true
                        ? widget.content.description!
                        : 'Este contenido no tiene descripcion disponible.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF435148),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _SectionCard(
              title: 'Como sera la actividad',
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _questions.isEmpty
                    ? []
                    : buildQuestionsFromRecords(_questions)
                        .take(4)
                        .map(
                          (question) => _QuestionTypeChip(
                            label: question.typeLabel,
                            color: metadata.palette.primary,
                            background: metadata.palette.soft,
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroBlock extends StatelessWidget {
  const _HeroBlock({
    required this.content,
    required this.isCompleted,
    required this.metadata,
  });

  final Content content;
  final bool isCompleted;
  final ContentActivityMetadata metadata;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            metadata.palette.soft,
            metadata.palette.soft.withValues(alpha: 0.86),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.82),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  metadata.palette.icon,
                  size: 30,
                  color: metadata.palette.primary,
                ),
              ),
              const Spacer(),
              _Badge(
                label: metadata.subjectLabel,
                backgroundColor: Colors.white.withValues(alpha: 0.82),
                foregroundColor: metadata.palette.text,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _Badge(
                label: metadata.activityLabel,
                backgroundColor: Colors.white.withValues(alpha: 0.7),
                foregroundColor: metadata.palette.text,
              ),
              _Badge(
                label: isCompleted ? 'Completado' : 'Pendiente',
                backgroundColor: isCompleted
                    ? const Color(0xFFE5F3E9)
                    : const Color(0xFFFFF1D6),
                foregroundColor: isCompleted
                    ? const Color(0xFF2C6B45)
                    : const Color(0xFF8E6318),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF1F2A24),
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            _heroMessage(metadata.subjectLabel),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF415048),
                  height: 1.45,
                ),
          ),
        ],
      ),
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.metadata});

  final ContentActivityMetadata metadata;

  @override
  Widget build(BuildContext context) {
    final items = [
      _SummaryItem(
        label: 'Tipo de ejercicio',
        value: metadata.activityLabel,
        icon: Icons.extension_outlined,
      ),
      _SummaryItem(
        label: 'Dificultad',
        value: metadata.difficulty,
        icon: Icons.signal_cellular_alt_outlined,
      ),
      _SummaryItem(
        label: 'Preguntas',
        value: '${metadata.questionCount}',
        icon: Icons.quiz_outlined,
      ),
      _SummaryItem(
        label: 'Tiempo',
        value: '${metadata.estimatedMinutes} min',
        icon: Icons.timer_outlined,
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items.map((item) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 52) / 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFD8D2C8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(item.icon, color: metadata.palette.primary),
                const SizedBox(height: 10),
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF1F2A24),
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF5C675F),
                      ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD8D2C8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF1F2A24),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _LearningGoalRow extends StatelessWidget {
  const _LearningGoalRow({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline, size: 20, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF415048),
                  height: 1.4,
                ),
          ),
        ),
      ],
    );
  }
}

class _QuestionTypeChip extends StatelessWidget {
  const _QuestionTypeChip({
    required this.label,
    required this.color,
    required this.background,
  });

  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foregroundColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SummaryItem {
  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}

String _heroMessage(String subjectLabel) {
  switch (subjectLabel) {
    case 'Lengua':
      return 'Hoy vas a leer, comprender ideas importantes y responder preguntas sencillas.';
    case 'Matematicas':
      return 'Hoy vas a practicar calculo basico y resolver ejercicios paso a paso.';
    case 'Ciencias':
      return 'Hoy vas a observar conceptos clave y relacionarlos con ejemplos simples.';
    case 'Sociales':
      return 'Hoy vas a comprender hechos, costumbres y contexto de tu comunidad.';
    default:
      return 'Hoy vas a repasar el contenido y completar una actividad guiada.';
  }
}
