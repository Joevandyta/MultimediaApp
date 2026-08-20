import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:multimedia_sticker_maker/presentation/provider/sticker_pack_provider.dart';
import 'package:multimedia_sticker_maker/presentation/widgets/sticker_pack_modal.dart';

class PacksScreen extends ConsumerStatefulWidget {
  const PacksScreen({super.key});

  @override
  ConsumerState<PacksScreen> createState() => _PacksScreenState();
}

class _PacksScreenState extends ConsumerState<PacksScreen> {
  int? _sharingPackId;
  

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
        backgroundColor: const Color(0xFFFF4B4B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _sharePack(StickerPack pack) async {
    setState(() => _sharingPackId = pack.isarId);
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
        setState(() => _sharingPackId = null);
      }
    }
  }

  void _deletePack(StickerPack pack) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF111A16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: const Color(0xFF25D366).withValues(alpha: 0.2),
            ),
          ),
          title: const Text(
            'Hapus Paket Stiker?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus paket stiker "${pack.name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4B4B),
                foregroundColor: Colors.white,
                minimumSize: const Size(80, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);
                await ref
                    .read(stickerPackProviderProvider.notifier)
                    .deleteStickerPack(pack.isarId);
                _showSuccessSnack('Paket stiker berhasil dihapus');
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final packsAsync = ref.watch(stickerPackProviderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paket Stiker Saya',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: packsAsync.when(
        data: (packs) => packs.isEmpty ? _buildEmptyState() : _buildGrid(packs),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF00FF41)),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_books_outlined,
            size: 64,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada paket stiker yang dibuat',
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.push('/packs/new/stickers/new');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FF41),
              foregroundColor: Colors.black,
              minimumSize: const Size(180, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Buat Paket Stiker',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<StickerPack> packs) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.82,
      ),
      itemCount: packs.length,
      itemBuilder: (context, index) {
        final pack = packs[index];
        final stickersCount = pack.stickers.length;
        final isSharingThis = _sharingPackId == pack.isarId;

        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => showStickerPackModal(
              context: context,
              pack: pack,
              onShare: () => _sharePack(pack),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tray Image Area
                Expanded(
                  child: Container(
                    color: Colors.black12,
                    padding: const EdgeInsets.all(16),
                    child: pack.trayImagePath.isNotEmpty
                        ? Image.file(
                            File(pack.trayImagePath),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.collections_bookmark_rounded,
                              size: 40,
                              color: Color(0xFF25D366),
                            ),
                          )
                        : const Icon(
                            Icons.collections_bookmark_rounded,
                            size: 40,
                            color: Color(0xFF25D366),
                          ),
                  ),
                ),
                // Details Area
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pack.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Oleh ${pack.publisher}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$stickersCount Stiker',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF00FF41),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Action Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // WhatsApp button
                          IconButton(
                            onPressed: isSharingThis
                                ? null
                                : () => _sharePack(pack),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF25D366,
                              ).withValues(alpha: 0.1),
                              foregroundColor: const Color(0xFF25D366),
                              padding: const EdgeInsets.all(8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: isSharingThis
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF25D366),
                                      ),
                                    ),
                                  )
                                : const Icon(Icons.share_rounded, size: 18),
                          ),
                          // Delete button
                          IconButton(
                            onPressed: () => _deletePack(pack),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.red.withValues(
                                alpha: 0.1,
                              ),
                              foregroundColor: Colors.redAccent,
                              padding: const EdgeInsets.all(8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
