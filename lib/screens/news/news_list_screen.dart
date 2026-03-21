import 'package:aplicacion_educativa/data/database.dart';
import 'package:aplicacion_educativa/screens/news/news_detail_screen.dart';
import 'package:aplicacion_educativa/screens/news/news_support.dart';
import 'package:aplicacion_educativa/screens/news/widgets/news_image_view.dart';
import 'package:flutter/material.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<NewsItem>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _loadNews();
  }

  Future<List<NewsItem>> _loadNews() => appDatabase.getAllNews();

  Future<void> _refresh() async {
    final future = _loadNews();
    setState(() {
      _newsFuture = future;
    });
    await future;
  }

  void _openDetail(NewsItem newsItem) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsDetailScreen(newsItem: newsItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1E8),
      appBar: AppBar(
        title: const Text('Noticias'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder<List<NewsItem>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _NewsStateMessage(
              icon: Icons.error_outline,
              title: 'No fue posible cargar las noticias.',
              body:
                  'Intenta actualizar para volver a leer los avisos guardados en tu dispositivo.',
              actionLabel: 'Intentar de nuevo',
              onAction: _refresh,
            );
          }

          final newsItems = snapshot.data ?? const <NewsItem>[];

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                _NewsHeroHeader(newsCount: newsItems.length),
                const SizedBox(height: 20),
                Text(
                  'Avisos recientes',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF1F2A24),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Comunicados locales ordenados del mas reciente al mas antiguo.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF58655D),
                  ),
                ),
                const SizedBox(height: 14),
                if (newsItems.isEmpty)
                  const _EmptyNewsState()
                else
                  ...[
                    for (final newsItem in newsItems) ...[
                      _NewsCard(
                        newsItem: newsItem,
                        onTap: () => _openDetail(newsItem),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NewsHeroHeader extends StatelessWidget {
  const _NewsHeroHeader({required this.newsCount});

  final int newsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF1E7D5),
            Color(0xFFE5EDD8),
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
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.82),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.campaign_outlined,
                  size: 28,
                  color: Color(0xFF9A6B16),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wifi_off_rounded,
                      size: 16,
                      color: Color(0xFF5C675F),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Sin internet',
                      style: TextStyle(
                        color: Color(0xFF5C675F),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Noticias y avisos',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF1F2A24),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Consulta comunicados escolares y novedades guardadas localmente. '
            'Ahora tienes $newsCount noticia${newsCount == 1 ? '' : 's'} disponible${newsCount == 1 ? '' : 's'}.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF435148),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({
    required this.newsItem,
    required this.onTap,
  });

  final NewsItem newsItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF9),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: const Color(0xFFD8D2C8)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewsImageView(
                imagePath: newsItem.imagePath,
                height: 170,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _MetaPill(
                          icon: Icons.event_outlined,
                          label: formatNewsDate(newsItem.publishedAt),
                          foregroundColor: const Color(0xFF2F6B52),
                          backgroundColor: const Color(0xFFE5F3E9),
                        ),
                        const _MetaPill(
                          icon: Icons.article_outlined,
                          label: 'Comunicado',
                          foregroundColor: Color(0xFF8C6117),
                          backgroundColor: Color(0xFFF9EBCD),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      newsItem.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF1F2A24),
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      buildNewsExcerpt(newsItem.body, maxLength: 145),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF4D5A51),
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Text(
                          'Leer noticia',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: const Color(0xFF2F6B52),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFF2F6B52),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({
    required this.icon,
    required this.label,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  final IconData icon;
  final String label;
  final Color foregroundColor;
  final Color backgroundColor;

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

class _EmptyNewsState extends StatelessWidget {
  const _EmptyNewsState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD8D2C8)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.newspaper_outlined,
            size: 40,
            color: Color(0xFF657168),
          ),
          const SizedBox(height: 12),
          Text(
            'Todavia no hay noticias guardadas.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF26322B),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cuando agregues avisos o comunicados a la base local, apareceran aqui.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF58655D),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsStateMessage extends StatelessWidget {
  const _NewsStateMessage({
    required this.icon,
    required this.title,
    required this.body,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String body;
  final String actionLabel;
  final Future<void> Function() onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: const Color(0xFF607068)),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF5A655E),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => onAction(),
              child: Text(actionLabel),
            ),
          ],
        ),
      ),
    );
  }
}
