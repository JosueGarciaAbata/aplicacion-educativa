import 'dart:async';

import 'package:aplicacion_educativa/data/database.dart';
import 'package:aplicacion_educativa/screens/content/content_activity_support.dart';
import 'package:aplicacion_educativa/screens/content/content_detail_screen.dart';
import 'package:aplicacion_educativa/services/session_manager.dart';
import 'package:flutter/material.dart';

class ContentListScreen extends StatelessWidget {
  const ContentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF6F1E8),
      appBar: _ContentAppBar(title: 'Contenido educativo'),
      body: ContentListView(),
    );
  }
}

class ContentListView extends StatefulWidget {
  const ContentListView({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(20, 12, 20, 28),
  });

  final EdgeInsets padding;

  @override
  State<ContentListView> createState() => _ContentListViewState();
}

class _ContentListViewState extends State<ContentListView> {
  Future<_DashboardData>? _dashboardFuture;
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _dashboardFuture = _loadData();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<_DashboardData> _loadData() async {
    final sessionUsername = await SessionManager.getUsername();
    if (sessionUsername == null) {
      throw Exception('No hay una sesion activa.');
    }

    final currentUser = await appDatabase.getSessionUser(sessionUsername);
    if (currentUser == null) {
      throw Exception('No se encontro el usuario actual.');
    }

    final allContents = await appDatabase.getAllContents();
    final activityDetailsMap = await appDatabase.getActivityDetailsMap();
    final progress = await appDatabase.getProgressForUser(currentUser.id);
    final completedContentIds = progress
        .where((item) => item.status == 'completed')
        .map((item) => item.contentId)
        .toSet();

    final query = _searchQuery.trim().toLowerCase();
    final filteredContents = query.isEmpty
        ? allContents
        : allContents.where((content) {
            final details = activityDetailsMap[content.id];
            final haystack = [
              content.title,
              content.description ?? '',
              content.category ?? '',
              content.type,
              details?.subjectLabel ?? '',
              details?.activityLabel ?? '',
            ].join(' ').toLowerCase();

            return haystack.contains(query);
          }).toList();

    final pendingContents = filteredContents
        .where((content) => !completedContentIds.contains(content.id))
        .toList();
    final completedContents = filteredContents
        .where((content) => completedContentIds.contains(content.id))
        .toList();
    final continueLearning = pendingContents.isNotEmpty
        ? pendingContents.first
        : null;
    final remainingPending = continueLearning == null
        ? pendingContents
        : pendingContents.skip(1).toList();
    final recommendedContents = remainingPending.take(3).toList();
    return _DashboardData(
      currentUser: currentUser,
      continueLearning: continueLearning,
      pendingContents: remainingPending,
      recommendedContents: recommendedContents,
      completedContents: completedContents,
      completedContentIds: completedContentIds,
      activityDetailsMap: activityDetailsMap,
      searchQuery: _searchQuery,
    );
  }

  Future<void> _refresh() async {
    final future = _loadData();
    setState(() {
      _dashboardFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_DashboardData>(
      future: _dashboardFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _StateMessage(
            icon: Icons.error_outline,
            title: 'No fue posible cargar los contenidos.',
            body: 'Intenta actualizar para volver a cargar el contenido local.',
            actionLabel: 'Intentar de nuevo',
            onAction: _refresh,
          );
        }

        final data = snapshot.data;
        if (data == null) {
          return _StateMessage(
            icon: Icons.menu_book_outlined,
            title: 'No hay datos disponibles.',
            body: 'No encontramos informacion para mostrar en este momento.',
            actionLabel: 'Actualizar',
            onAction: _refresh,
          );
        }

        return RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: widget.padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderBlock(userName: data.currentUser.name),
                const SizedBox(height: 18),
                _SearchBlock(
                  controller: _searchController,
                  initialValue: data.searchQuery,
                  onChanged: _handleSearchChanged,
                  onSubmitted: _applySearchNow,
                  onClear: _clearSearch,
                ),
                const SizedBox(height: 18),
                if (data.continueLearning != null) ...[
                  _SectionTitle(
                    title: 'Continuar aprendiendo',
                    subtitle: 'Retoma tu siguiente actividad pendiente.',
                  ),
                  const SizedBox(height: 12),
                  _FeaturedCard(
                    content: data.continueLearning!,
                    isCompleted: false,
                    activityDetails: data.activityDetailsMap[
                      data.continueLearning!.id
                    ],
                    onTap: () => _openDetail(
                      content: data.continueLearning!,
                      userId: data.currentUser.id,
                    ),
                  ),
                  const SizedBox(height: 22),
                ],
                _SectionTitle(
                  title: 'Actividades pendientes',
                  subtitle: 'Bloques cortos para avanzar sin demasiado scroll.',
                ),
                const SizedBox(height: 12),
                if (data.pendingContents.isEmpty)
                  _EmptySection(
                    title: data.searchQuery.isEmpty
                        ? 'No tienes actividades pendientes.'
                        : 'No encontramos pendientes para esa busqueda.',
                    body: data.searchQuery.isEmpty
                        ? 'Cuando termines nuevas actividades, tu avance se organizara aqui.'
                        : 'Prueba con otra palabra o revisa tus actividades completadas.',
                  )
                else
                  _PendingGrid(
                    contents: data.pendingContents,
                    completedIds: data.completedContentIds,
                    activityDetailsMap: data.activityDetailsMap,
                    onTap: (content) => _openDetail(
                      content: content,
                      userId: data.currentUser.id,
                    ),
                  ),
                const SizedBox(height: 22),
                if (data.recommendedContents.isNotEmpty) ...[
                  _SectionTitle(
                    title: 'Recomendados',
                    subtitle: 'Sugerencias para seguir practicando.',
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.recommendedContents.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final content = data.recommendedContents[index];
                        return SizedBox(
                          width: 250,
                          child: _CompactCard(
                            content: content,
                            isCompleted: false,
                            label: 'Recomendado',
                            activityDetails: data.activityDetailsMap[content.id],
                            onTap: () => _openDetail(
                              content: content,
                              userId: data.currentUser.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 22),
                ],
                _SectionTitle(
                  title: 'Completados recientemente',
                  subtitle: 'Lo que ya lograste queda visible y ordenado.',
                ),
                const SizedBox(height: 12),
                if (data.completedContents.isEmpty)
                  const _EmptySection(
                    title: 'Aun no has completado actividades.',
                    body: 'Cuando termines una actividad, aparecera aqui.',
                  )
                else
                  SizedBox(
                    height: 170,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.completedContents.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final content = data.completedContents[index];
                        return SizedBox(
                          width: 220,
                          child: _CompactCard(
                            content: content,
                            isCompleted: true,
                            label: 'Listo',
                            activityDetails: data.activityDetailsMap[content.id],
                            onTap: () => _openDetail(
                              content: content,
                              userId: data.currentUser.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 450), () {
      _applySearch(value);
    });
  }

  void _applySearchNow(String value) {
    _searchDebounce?.cancel();
    _applySearch(value);
  }

  void _clearSearch() {
    _searchDebounce?.cancel();
    _searchController.clear();
    _applySearch('');
  }

  void _applySearch(String value) {
    final normalized = value.trim();
    if (normalized == _searchQuery) {
      return;
    }

    setState(() {
      _searchQuery = normalized;
      _dashboardFuture = _loadData();
    });
  }

  Future<void> _openDetail({
    required Content content,
    required int userId,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ContentDetailScreen(
          content: content,
          userId: userId,
        ),
      ),
    );

    await _refresh();
  }
}

class _ContentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ContentAppBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderBlock extends StatelessWidget {
  const _HeaderBlock({required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE8F0E4),
            Color(0xFFDDE8D9),
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
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  size: 28,
                  color: Color(0xFF2F6B52),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wifi_off_rounded,
                      size: 16,
                      color: Color(0xFF2F6B52),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Sin internet',
                      style: TextStyle(
                        color: Color(0xFF2F6B52),
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
            'Hola, $userName',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF1F2A24),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tu aprendizaje esta organizado por bloques para que avances mas rapido y con menos scroll.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF415048),
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}

class _SearchBlock extends StatelessWidget {
  const _SearchBlock({
    required this.controller,
    required this.initialValue,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  final TextEditingController controller;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    if (controller.text != initialValue) {
      controller.value = controller.value.copyWith(
        text: initialValue,
        selection: TextSelection.collapsed(offset: initialValue.length),
        composing: TextRange.empty,
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD8D2C8)),
      ),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          return TextField(
            controller: controller,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Buscar por titulo, materia o actividad',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: value.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: onClear,
                      tooltip: 'Limpiar busqueda',
                      icon: const Icon(Icons.close_rounded),
                    ),
              filled: true,
              fillColor: const Color(0xFFF6F1E8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Color(0xFFD8D2C8)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Color(0xFFD8D2C8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Color(0xFF2F6B52),
                  width: 1.5,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF1F2A24),
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF58655D),
              ),
        ),
      ],
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({
    required this.content,
    required this.isCompleted,
    required this.activityDetails,
    required this.onTap,
  });

  final Content content;
  final bool isCompleted;
  final ContentActivityDetail? activityDetails;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final metadata = buildActivityMetadata(
      content: content,
      details: activityDetails,
      isCompleted: isCompleted,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Ink(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF9),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFFD8D2C8)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 18,
                offset: Offset(0, 10),
              ),
            ],
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
                      color: metadata.palette.soft,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      metadata.palette.icon,
                      color: metadata.palette.primary,
                    ),
                  ),
                  const Spacer(),
                  _StatusPill(
                    isCompleted: isCompleted,
                    text: isCompleted ? 'Completado' : 'Pendiente',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                content.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF1F2A24),
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                content.description?.trim().isNotEmpty == true
                    ? content.description!
                    : 'Actividad lista para comenzar.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF47544B),
                      height: 1.45,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoPill(
                    text: metadata.subjectLabel,
                    color: metadata.palette.primary,
                    background: metadata.palette.soft,
                  ),
                  _InfoPill(
                    text: metadata.activityLabel,
                    color: metadata.palette.text,
                    background: const Color(0xFFF2EEE5),
                  ),
                  _InfoPill(
                    text: '${metadata.questionCount} preguntas',
                    color: const Color(0xFF5A655E),
                    background: const Color(0xFFF5F2EA),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              LinearProgressIndicator(
                value: metadata.progress,
                minHeight: 8,
                borderRadius: BorderRadius.circular(999),
                backgroundColor: const Color(0xFFE9E4DA),
                color: metadata.palette.primary,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    isCompleted ? 'Actividad terminada' : 'Lista para continuar',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF5C675F),
                        ),
                  ),
                  const Spacer(),
                  Text(
                    metadata.ctaLabel,
                    style: TextStyle(
                      color: metadata.palette.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PendingGrid extends StatelessWidget {
  const _PendingGrid({
    required this.contents,
    required this.completedIds,
    required this.activityDetailsMap,
    required this.onTap,
  });

  final List<Content> contents;
  final Set<int> completedIds;
  final Map<int, ContentActivityDetail> activityDetailsMap;
  final ValueChanged<Content> onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 680;
        final cardWidth = isWide
            ? (constraints.maxWidth - 12) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: contents.map((content) {
            return SizedBox(
              width: cardWidth,
              child: _DashboardCard(
                content: content,
                isCompleted: completedIds.contains(content.id),
                activityDetails: activityDetailsMap[content.id],
                onTap: () => onTap(content),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.content,
    required this.isCompleted,
    required this.activityDetails,
    required this.onTap,
  });

  final Content content;
  final bool isCompleted;
  final ContentActivityDetail? activityDetails;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final metadata = buildActivityMetadata(
      content: content,
      details: activityDetails,
      isCompleted: isCompleted,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFD8D2C8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: metadata.palette.soft,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      metadata.palette.icon,
                      color: metadata.palette.primary,
                    ),
                  ),
                  const Spacer(),
                  _StatusPill(
                    isCompleted: isCompleted,
                    text: isCompleted ? 'Completado' : 'Pendiente',
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                content.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF1F2A24),
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                content.description?.trim().isNotEmpty == true
                    ? content.description!
                    : 'Actividad sin descripcion adicional.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF4B584F),
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoPill(
                    text: metadata.subjectLabel,
                    color: metadata.palette.primary,
                    background: metadata.palette.soft,
                  ),
                  _InfoPill(
                    text: displayTypeLabel(content.type),
                    color: const Color(0xFF5A655E),
                    background: const Color(0xFFF2EEE5),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              LinearProgressIndicator(
                value: metadata.progress,
                minHeight: 7,
                borderRadius: BorderRadius.circular(999),
                backgroundColor: const Color(0xFFE8E3D8),
                color: metadata.palette.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompactCard extends StatelessWidget {
  const _CompactCard({
    required this.content,
    required this.isCompleted,
    required this.label,
    required this.activityDetails,
    required this.onTap,
  });

  final Content content;
  final bool isCompleted;
  final String label;
  final ContentActivityDetail? activityDetails;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final metadata = buildActivityMetadata(
      content: content,
      details: activityDetails,
      isCompleted: isCompleted,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF9),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFD8D2C8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: metadata.palette.soft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  metadata.palette.icon,
                  color: metadata.palette.primary,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                content.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF1F2A24),
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoPill(
                    text: label,
                    color: metadata.palette.primary,
                    background: metadata.palette.soft,
                  ),
                  _InfoPill(
                    text: metadata.subjectLabel,
                    color: const Color(0xFF5A655E),
                    background: const Color(0xFFF2EEE5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({
    required this.text,
    required this.color,
    required this.background,
  });

  final String text;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12.5,
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.isCompleted,
    required this.text,
  });

  final bool isCompleted;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: isCompleted
            ? const Color(0xFFE5F3E9)
            : const Color(0xFFFFF1D8),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color:
              isCompleted ? const Color(0xFF2F6B52) : const Color(0xFF9A6B16),
          fontWeight: FontWeight.w700,
          fontSize: 12.5,
        ),
      ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  const _EmptySection({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD8D2C8)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.inbox_outlined,
            size: 38,
            color: Color(0xFF657168),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF26322B),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF58655D),
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}

class _StateMessage extends StatelessWidget {
  const _StateMessage({
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

class _DashboardData {
  const _DashboardData({
    required this.currentUser,
    required this.continueLearning,
    required this.pendingContents,
    required this.recommendedContents,
    required this.completedContents,
    required this.completedContentIds,
    required this.activityDetailsMap,
    required this.searchQuery,
  });

  final User currentUser;
  final Content? continueLearning;
  final List<Content> pendingContents;
  final List<Content> recommendedContents;
  final List<Content> completedContents;
  final Set<int> completedContentIds;
  final Map<int, ContentActivityDetail> activityDetailsMap;
  final String searchQuery;
}
