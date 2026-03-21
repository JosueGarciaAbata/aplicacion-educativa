import 'package:aplicacion_educativa/data/database.dart';

typedef NewsItem = New;

String formatNewsDate(String? publishedAt) {
  if (publishedAt == null || publishedAt.trim().isEmpty) {
    return 'Sin fecha';
  }

  final parsed = DateTime.tryParse(publishedAt);
  if (parsed == null) {
    return publishedAt;
  }

  const months = [
    'ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sep',
    'oct',
    'nov',
    'dic',
  ];

  final month = months[parsed.month - 1];
  return '${parsed.day} $month ${parsed.year}';
}

String buildNewsExcerpt(
  String body, {
  int maxLength = 120,
}) {
  final normalized = body.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (normalized.length <= maxLength) {
    return normalized;
  }

  return '${normalized.substring(0, maxLength).trimRight()}...';
}
