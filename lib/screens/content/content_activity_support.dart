import 'dart:convert';

import 'package:aplicacion_educativa/data/database.dart';
import 'package:flutter/material.dart';

class SubjectPalette {
  const SubjectPalette({
    required this.primary,
    required this.soft,
    required this.text,
    required this.icon,
  });

  final Color primary;
  final Color soft;
  final Color text;
  final IconData icon;
}

class ContentActivityMetadata {
  const ContentActivityMetadata({
    required this.subjectLabel,
    required this.activityLabel,
    required this.ctaLabel,
    required this.difficulty,
    required this.questionCount,
    required this.estimatedMinutes,
    required this.learningGoals,
    required this.palette,
    required this.progress,
  });

  final String subjectLabel;
  final String activityLabel;
  final String ctaLabel;
  final String difficulty;
  final int questionCount;
  final int estimatedMinutes;
  final List<String> learningGoals;
  final SubjectPalette palette;
  final double progress;
}

class ActivityQuestion {
  const ActivityQuestion({
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

ContentActivityMetadata buildActivityMetadata({
  required Content content,
  required ContentActivityDetail? details,
  required bool isCompleted,
}) {
  final subjectLabel = details?.subjectLabel ?? _fallbackSubject(content.category);
  final palette = paletteForSubject(subjectLabel);

  return ContentActivityMetadata(
    subjectLabel: subjectLabel,
    activityLabel: details?.activityLabel ?? 'Actividad guiada',
    ctaLabel: isCompleted
        ? 'Volver a practicar'
        : (details?.ctaLabel ?? 'Iniciar actividad'),
    difficulty: details?.difficulty ?? 'Basico',
    questionCount: details?.questionCount ?? 0,
    estimatedMinutes: details?.estimatedMinutes ?? 5,
    learningGoals: details == null
        ? const [
            'Leer el contenido principal',
            'Responder preguntas sencillas',
            'Reforzar lo aprendido',
          ]
        : _decodeStringList(details.learningGoals),
    palette: palette,
    progress: isCompleted ? 1 : 0,
  );
}

List<ActivityQuestion> buildQuestionsFromRecords(
  List<ContentQuestion> records,
) {
  return records
      .map(
        (record) => ActivityQuestion(
          typeLabel: record.typeLabel,
          prompt: record.prompt,
          options: _decodeStringList(record.optionsText),
          correctIndex: record.correctIndex,
        ),
      )
      .toList();
}

SubjectPalette paletteForSubject(String subjectLabel) {
  final normalized = subjectLabel.trim().toLowerCase();

  if (normalized.contains('lengua') || normalized.contains('literatura')) {
    return const SubjectPalette(
      primary: Color(0xFFB8664A),
      soft: Color(0xFFF8E8E1),
      text: Color(0xFF6E3D2E),
      icon: Icons.auto_stories_rounded,
    );
  }
  if (normalized.contains('mat')) {
    return const SubjectPalette(
      primary: Color(0xFF2F7C8F),
      soft: Color(0xFFE3F4F7),
      text: Color(0xFF194B57),
      icon: Icons.calculate_rounded,
    );
  }
  if (normalized.contains('ciencia')) {
    return const SubjectPalette(
      primary: Color(0xFF4A8A5B),
      soft: Color(0xFFE5F3E8),
      text: Color(0xFF2E5A3A),
      icon: Icons.eco_rounded,
    );
  }
  if (normalized.contains('social') || normalized.contains('comunidad')) {
    return const SubjectPalette(
      primary: Color(0xFFC0882E),
      soft: Color(0xFFF8EDD8),
      text: Color(0xFF734F17),
      icon: Icons.public_rounded,
    );
  }

  return const SubjectPalette(
    primary: Color(0xFF6C7A73),
    soft: Color(0xFFECEFEA),
    text: Color(0xFF445049),
    icon: Icons.menu_book_rounded,
  );
}

String displayTypeLabel(String type) {
  switch (type.trim().toLowerCase()) {
    case 'texto':
      return 'Lectura';
    case 'imagen':
      return 'Visual';
    case 'multimedia':
      return 'Interactivo';
    default:
      return type;
  }
}

String _fallbackSubject(String? category) {
  final value = (category ?? '').trim();
  if (value.isEmpty) {
    return 'Aprendizaje';
  }
  return value;
}

List<String> _decodeStringList(String source) {
  final decoded = jsonDecode(source);
  if (decoded is List) {
    return decoded.map((item) => item.toString()).toList();
  }
  return const [];
}
