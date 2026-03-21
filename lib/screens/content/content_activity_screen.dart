import 'package:aplicacion_educativa/data/database.dart';
import 'package:aplicacion_educativa/screens/content/content_activity_support.dart';
import 'package:flutter/material.dart';

class ContentActivityScreen extends StatefulWidget {
  const ContentActivityScreen({
    super.key,
    required this.content,
    required this.userId,
  });

  final Content content;
  final int userId;

  @override
  State<ContentActivityScreen> createState() => _ContentActivityScreenState();
}

class _ContentActivityScreenState extends State<ContentActivityScreen> {
  List<ActivityQuestion> _questions = const [];
  List<int?> _answers = const [];
  ContentActivityDetail? _activityDetails;
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadActivity();
  }

  Future<void> _loadActivity() async {
    final details = await appDatabase.getActivityDetailsForContent(
      widget.content.id,
    );
    final questionRecords = await appDatabase.getQuestionsForContent(
      widget.content.id,
    );
    final questions = buildQuestionsFromRecords(questionRecords);

    if (!mounted) {
      return;
    }

    setState(() {
      _activityDetails = details;
      _questions = questions;
      _answers = List<int?>.filled(questions.length, null);
      _isLoading = false;
    });
  }

  Future<void> _finishActivity() async {
    if (_answers.any((answer) => answer == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Responde todas las preguntas antes de continuar.'),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final correctAnswers = _answers.asMap().entries.where((entry) {
      final index = entry.key;
      final selected = entry.value;
      return selected == _questions[index].correctIndex;
    }).length;

    await appDatabase.markContentAsCompleted(
      userId: widget.userId,
      contentId: widget.content.id,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Actividad terminada'),
          content: Text(
            'Respondiste $correctAnswers de ${_questions.length} preguntas correctamente.',
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF6F1E8),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final metadata = buildActivityMetadata(
      content: widget.content,
      details: _activityDetails,
      isCompleted: false,
    );
    final answeredCount = _answers.where((answer) => answer != null).length;
    final progress = _questions.isEmpty ? 0.0 : answeredCount / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1E8),
      appBar: AppBar(
        title: const Text('Actividad'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: 54,
          child: FilledButton.icon(
            onPressed: _isSubmitting ? null : _finishActivity,
            style: FilledButton.styleFrom(
              backgroundColor: metadata.palette.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            icon: const Icon(Icons.task_alt_outlined),
            label: Text(
              _isSubmitting ? 'Guardando resultado...' : 'Finalizar actividad',
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: metadata.palette.soft,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metadata.activityLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: metadata.palette.text,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${answeredCount}/${_questions.length} preguntas respondidas',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: metadata.palette.text,
                      ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(999),
                  backgroundColor: Colors.white.withValues(alpha: 0.6),
                  color: metadata.palette.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          for (var index = 0; index < _questions.length; index++) ...[
            _QuestionCard(
              number: index + 1,
              question: _questions[index],
              selectedIndex: _answers[index],
              accentColor: metadata.palette.primary,
              onChanged: (selectedIndex) {
                setState(() {
                  _answers[index] = selectedIndex;
                });
              },
            ),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.number,
    required this.question,
    required this.selectedIndex,
    required this.accentColor,
    required this.onChanged,
  });

  final int number;
  final ActivityQuestion question;
  final int? selectedIndex;
  final Color accentColor;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFD9D3C9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Pregunta $number · ${question.typeLabel}',
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            question.prompt,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF1F2A24),
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: 12),
          for (var optionIndex = 0;
              optionIndex < question.options.length;
              optionIndex++) ...[
            RadioListTile<int>(
              value: optionIndex,
              groupValue: selectedIndex,
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
              activeColor: accentColor,
              contentPadding: EdgeInsets.zero,
              title: Text(question.options[optionIndex]),
            ),
          ],
        ],
      ),
    );
  }
}
