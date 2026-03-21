import 'package:aplicacion_educativa/screens/news/news_support.dart';
import 'package:aplicacion_educativa/screens/news/widgets/news_image_view.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({
    super.key,
    required this.newsItem,
  });

  final NewsItem newsItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1E8),
      appBar: AppBar(
        title: const Text('Noticia'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE8F0E4),
                    Color(0xFFF3EBDD),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NewsImageView(
                    imagePath: newsItem.imagePath,
                    height: 220,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _InfoBadge(
                        icon: Icons.event_outlined,
                        label: formatNewsDate(newsItem.publishedAt),
                        backgroundColor: Colors.white.withValues(alpha: 0.8),
                        foregroundColor: const Color(0xFF2F6B52),
                      ),
                      _InfoBadge(
                        icon: Icons.wifi_off_rounded,
                        label: 'Disponible sin internet',
                        backgroundColor: Colors.white.withValues(alpha: 0.8),
                        foregroundColor: const Color(0xFF5C675F),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    newsItem.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF1F2A24),
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Aviso o comunicado guardado en tu dispositivo para consultarlo cuando lo necesites.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF435148),
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF9),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFD8D2C8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contenido completo',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF1F2A24),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    newsItem.body.trim(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF2F3C34),
                      height: 1.65,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final IconData icon;
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: foregroundColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
