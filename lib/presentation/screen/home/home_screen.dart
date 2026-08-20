import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:multimedia_sticker_maker/presentation/provider/sticker_pack_provider.dart';
import 'package:multimedia_sticker_maker/presentation/widgets/delete_confirm_modal.dart';
import 'package:multimedia_sticker_maker/presentation/widgets/sticker_pack_modal.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  bool _isSharing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              title: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF25D366).withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0xFF25D366),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Stickerify',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      Text(
                        'Make your own sticker',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white.withValues(alpha: 0.45),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(cardColor: const Color(0xFF111A16)),
                    child: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: Color(0xFF25D366),
                        size: 24,
                      ),
                      offset: const Offset(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: const Color(
                            0xFF00FF41,
                          ).withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      onSelected: (value) {
                        if (value == 'stickers') {
                          context.push('/stickers');
                        } else if (value == 'packs') {
                          context.push('/packs');
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'packs',
                          child: Row(
                            children: [
                              const Icon(
                                Icons.folder_special_rounded,
                                color: Color(0xFF00FF41),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Sticker Pack Tersimpan',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _packSlider(),
          //_featureGrid(),
          // Bottom space to prevent overlap with the floating bottom bar
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
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
        backgroundColor: const Color(0xFF00FF41),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 120),
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
        backgroundColor: const Color(0xFFFF4B4B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 120),
      ),
    );
  }

  Widget _packSlider() {
    final packsAsync = ref.watch(stickerPackProviderProvider);

    return packsAsync.when(
      data: (packs) {
        if (packs.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  'No sticker packs yet',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final pack = packs[index];
              return _buildStickerPackItem(pack);
            }, childCount: packs.length),
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: CircularProgressIndicator(color: Color(0xFF00FF41)),
          ),
        ),
      ),
      error: (err, stack) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(
              'Error: $err',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStickerPackItem(StickerPack pack) {
    final stickersList = pack.stickers.toList();

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          backgroundColor: const Color(0xFF111A16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          isScrollControlled: true,
          builder: (_) => StickerPackModalSheet(
            pack: pack,
            onShare: () => _sharePack(pack),
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          backgroundColor: const Color(0xFF111A16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (modalContext) => DeleteConfirmModal(
            title: 'Hapus Stiker Pack?',
            message:
                'Apakah kamu yakin ingin menghapus stiker pack "${pack.name}"?',
            onConfirm: () async {
              Navigator.pop(modalContext);
              await ref
                  .read(stickerPackProviderProvider.notifier)
                  .deletePack(pack);
              _showSuccessSnack('Stiker pack "${pack.name}" berhasil dihapus');
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Add Button Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Pack title and time
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                pack.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 0.1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              timeago.format(pack.lastEdited),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.35),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              pack.publisher,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.45),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Add to WhatsApp button
                InkWell(
                  onTap: _isSharing
                      ? null
                      : () async {
                          setState(() => _isSharing = true);
                          try {
                            if (pack.stickers.length < 3) {
                              _showErrorSnack(
                                'Pack harus memiliki minimal 3 stiker',
                              );
                              return;
                            }
                            await pack.shareToWhatsApp();
                          } catch (e) {
                            if (mounted) _showErrorSnack('Gagal share: $e');
                          } finally {
                            if (mounted) setState(() => _isSharing = false);
                          }
                        },
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height: 34,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFF25D366).withValues(alpha: 0.35),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isSharing) ...[
                          SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                const Color(0xFF25D366),
                              ),
                            ),
                          ),
                        ] else ...[
                          Icon(
                            Icons.add_rounded,
                            size: 16,
                            color: const Color(0xFF25D366),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Add',
                            style: TextStyle(
                              color: const Color(0xFF25D366),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Horizontal stickers list
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),

              itemCount: stickersList.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, stickerIndex) {
                return _buildStickerItem(stickersList[stickerIndex]);
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStickerItem(StickerModel sticker) {
    debugPrint("image stickerpath ${sticker.imagePath}");
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          image: DecorationImage(
            image: FileImage(File(sticker.imagePath)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _sharePack(StickerPack pack) async {
    setState(() => _isSharing = true);
    try {
      if (pack.stickers.length < 3) {
        _showErrorSnack('Pack harus memiliki minimal 3 stiker');
        return;
      }
      await pack.shareToWhatsApp();
      _showSuccessSnack('Pack berhasil dikirim ke WhatsApp!');
    } catch (e) {
      _showErrorSnack('Gagal share: $e');
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }
}
