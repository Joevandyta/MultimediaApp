import 'dart:developer';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:multimedia_sticker_maker/core/theme/app_theme.dart';
import 'package:multimedia_sticker_maker/data/models/remote/api_sticker_dto.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:multimedia_sticker_maker/presentation/provider/explore_sticker_provider.dart';
import 'package:multimedia_sticker_maker/presentation/provider/sticker_pack_provider.dart';
import 'package:multimedia_sticker_maker/presentation/widgets/select_sticker_pack_modal.dart';

class ExploreStickersScreen extends ConsumerStatefulWidget {
  const ExploreStickersScreen({super.key});

  @override
  ConsumerState<ExploreStickersScreen> createState() =>
      _ExploreStickersScreenState();
}

class _ExploreStickersScreenState extends ConsumerState<ExploreStickersScreen> {
  final _searchController = TextEditingController();
  final Map<String, ApiStickerDto> _selectedStickers = {};
  bool _isSavingToPack = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSuccessSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                msg,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                msg,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _showSaveToPackModal() async {
    if (_selectedStickers.isEmpty) return;

    final count = _selectedStickers.length;

    await SelectStickerPackModal.show(
      context: context,
      title: 'Simpan ke Pack',
      confirmTitle: 'Simpan $count Stiker?',
      confirmMessage: (pack) =>
          '$count stiker yang dipilih akan disimpan ke pack "${pack.name}"',
      onConfirmSave: (pack) async {
        return await _saveSelectedStickersToPack(pack);
      },
    );
  }

  Future<bool> _saveSelectedStickersToPack(StickerPack pack) async {
    setState(() => _isSavingToPack = true);

    BuildContext? progressDialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (dialogCtx) {
        progressDialogContext = dialogCtx;
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: const Color(0xFF111A16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: AppTheme.primaryAccent.withValues(alpha: 0.2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppTheme.primaryAccent,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Menyimpan ${_selectedStickers.length} stiker...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    try {
      final client = http.Client();
      final notifier = ref.read(stickerPackProviderProvider.notifier);
      final stickersToSave = _selectedStickers.values.toList();
      int savedCount = 0;

      for (final sticker in stickersToSave) {
        try {
          final response = await client.get(Uri.parse(sticker.image));
          if (response.statusCode == 200) {
            final Uint8List originalBytes = response.bodyBytes;

            // Process & resize image to 512px standard width
            Uint8List bytesToSave = originalBytes;
            final img.Image? decoded = img.decodeImage(originalBytes);
            if (decoded != null) {
              final img.Image resized = img.copyResize(decoded, width: 512);
              bytesToSave = Uint8List.fromList(img.encodePng(resized));
            }

            String extension = 'png';
            final uriPath = Uri.parse(sticker.image).path;
            if (uriPath.contains('.')) {
              final ext = uriPath.split('.').last.toLowerCase();
              if (['png', 'jpg', 'jpeg', 'webp'].contains(ext)) {
                extension = ext;
              }
            }

            await notifier.addStickerToPack(
              bytes: bytesToSave,
              extension: extension,
              emoji: ['☕', '🙂'],
              packId: pack.isarId,
            );
            savedCount++;
          }
        } catch (e) {
          log(
            'Error downloading/saving sticker ${sticker.id}: $e',
            name: 'ExploreStickers',
          );
        }
      }

      client.close();

      if (progressDialogContext != null && progressDialogContext!.mounted) {
        Navigator.of(progressDialogContext!).pop();
      } else if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      if (mounted) {
        setState(() {
          _selectedStickers.clear();
          _isSavingToPack = false;
        });
        _showSuccessSnack(
          '$savedCount stiker berhasil disimpan ke "${pack.name}"!',
        );
      }
      return true;
    } catch (e) {
      if (progressDialogContext != null && progressDialogContext!.mounted) {
        Navigator.of(progressDialogContext!).pop();
      } else if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      if (mounted) {
        setState(() => _isSavingToPack = false);
        _showErrorSnack('Gagal menyimpan stiker: $e');
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exploreStickersProvider);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          _buildSearchBar(),
          _buildTooltip(),
          if (state.isLoading && state.stickers.isEmpty)
            const SliverFillRemaining(child: _LoadingView())
          else if (state.error != null && state.stickers.isEmpty)
            SliverFillRemaining(
              child: _ErrorView(
                message: state.error!,
                onRetry: () =>
                    ref.read(exploreStickersProvider.notifier).retry(),
              ),
            )
          else if (!state.isLoading && state.stickers.isEmpty)
            const SliverFillRemaining(child: _EmptyView())
          else ...[
            _buildMasonryGrid(state.stickers),
            SliverToBoxAdapter(
              child: _PaginationControls(
                state: state,
                onPrevious: () =>
                    ref.read(exploreStickersProvider.notifier).previousPage(),
                onNext: () =>
                    ref.read(exploreStickersProvider.notifier).nextPage(),
              ),
            ),
          ],
        ],
      ),
      bottomNavigationBar: _buildSelectionActionBar(),
    );
  }

  Widget? _buildSelectionActionBar() {
    if (_selectedStickers.isEmpty) return null;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF111A16).withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(color: AppTheme.primaryAccent.withValues(alpha: 0.2)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedStickers.clear();
                });
              },
              child: Text(
                'Batal',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _isSavingToPack ? null : _showSaveToPackModal,
                icon: _isSavingToPack
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      )
                    : const Icon(Icons.bookmark_add_rounded, size: 20),
                label: Text(
                  'Simpan (${_selectedStickers.length} Stiker)',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 100,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryAccent, AppTheme.secondaryAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.explore_rounded,
                color: Colors.black,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Jelajahi Stiker',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: TextField(
          controller: _searchController,
          onChanged: (q) =>
              ref.read(exploreStickersProvider.notifier).onSearchChanged(q),
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: 'Cari stiker...',
            hintStyle: TextStyle(
              color: AppTheme.textSecondary.withValues(alpha: 0.7),
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppTheme.textSecondary,
            ),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (_, value, _) => value.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: AppTheme.textSecondary,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        ref
                            .read(exploreStickersProvider.notifier)
                            .onSearchChanged('');
                      },
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTooltip() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.primaryAccent.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: AppTheme.primaryAccent.withValues(alpha: 0.8),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Select stickers to save to your collection',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildMasonryGrid(List<ApiStickerDto> stickers) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childCount: stickers.length,
        itemBuilder: (context, index) {
          final sticker = stickers[index];
          final isSelected = _selectedStickers.containsKey(sticker.id);
          return _StickerCard(
            sticker: sticker,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedStickers.remove(sticker.id);
                } else {
                  _selectedStickers[sticker.id] = sticker;
                }
              });
            },
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sticker Card with Multi-Selection Support
// ---------------------------------------------------------------------------

class _StickerCard extends StatelessWidget {
  const _StickerCard({
    required this.sticker,
    required this.isSelected,
    required this.onTap,
  });

  final ApiStickerDto sticker;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final aspectRatio = sticker.width > 0 && sticker.height > 0
        ? sticker.width / sticker.height
        : 1.0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF16251E) : AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryAccent
                : AppTheme.primaryAccent.withValues(alpha: 0.15),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppTheme.primaryAccent.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: isSelected ? 12 : 8,
              spreadRadius: isSelected ? 1 : 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: aspectRatio,
                    child: CachedNetworkImage(
                      imageUrl: sticker.image,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => const _ImageSkeleton(),
                      errorWidget: (_, _, _) => const _ImageError(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sticker.title,
                          style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '@${sticker.username}',
                          style: TextStyle(
                            color: AppTheme.textSecondary.withValues(
                              alpha: 0.8,
                            ),
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isSelected) ...[
                // Tint overlay
                Positioned.fill(
                  child: Container(
                    color: AppTheme.primaryAccent.withValues(alpha: 0.08),
                  ),
                ),
                // Checkmark badge in top right
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pagination Controls
// ---------------------------------------------------------------------------

class _PaginationControls extends StatelessWidget {
  const _PaginationControls({
    required this.state,
    required this.onPrevious,
    required this.onNext,
  });

  final ExploreState state;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final pagination = state.pagination;
    if (pagination == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
      child: Column(
        children: [
          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.primaryAccent,
                ),
              ),
            ),
          Row(
            children: [
              // Previous button
              Expanded(
                child: AnimatedOpacity(
                  opacity: state.hasPreviousPage ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 200),
                  child: _NavButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    label: 'Sebelumnya',
                    onTap: state.hasPreviousPage && !state.isLoading
                        ? onPrevious
                        : null,
                  ),
                ),
              ),
              // Page indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      '${state.currentPage}',
                      style: const TextStyle(
                        color: AppTheme.primaryAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'dari ${pagination.totalPages}',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              // Next button
              Expanded(
                child: AnimatedOpacity(
                  opacity: state.hasNextPage ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 200),
                  child: _NavButton(
                    icon: Icons.arrow_forward_ios_rounded,
                    label: 'Berikutnya',
                    isNext: true,
                    onTap: state.hasNextPage && !state.isLoading
                        ? onNext
                        : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${pagination.total} stiker tersedia',
            style: TextStyle(
              color: AppTheme.textSecondary.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isNext = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isNext;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: onTap != null
                ? AppTheme.primaryAccent.withValues(alpha: 0.4)
                : AppTheme.textSecondary.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isNext
              ? [
                  Text(
                    label,
                    style: TextStyle(
                      color: onTap != null
                          ? AppTheme.primaryAccent
                          : AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    icon,
                    size: 14,
                    color: onTap != null
                        ? AppTheme.primaryAccent
                        : AppTheme.textSecondary,
                  ),
                ]
              : [
                  Icon(
                    icon,
                    size: 14,
                    color: onTap != null
                        ? AppTheme.primaryAccent
                        : AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      color: onTap != null
                          ? AppTheme.primaryAccent
                          : AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helper widgets: Loading, Error, Empty, Skeleton
// ---------------------------------------------------------------------------

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppTheme.primaryAccent),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 64,
              color: AppTheme.error.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 16),
            const Text(
              'Gagal memuat stiker',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          const Text(
            'Stiker tidak ditemukan',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class _ImageSkeleton extends StatelessWidget {
  const _ImageSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(color: AppTheme.surface);
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.surface,
      child: const Icon(
        Icons.broken_image_outlined,
        color: AppTheme.textSecondary,
      ),
    );
  }
}
