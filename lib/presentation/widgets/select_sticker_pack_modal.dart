import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:multimedia_sticker_maker/presentation/provider/sticker_pack_provider.dart';

/// Reusable modal sheet to select a [StickerPack] or create a new one,
/// and confirm saving stickers into the selected pack.
class SelectStickerPackModal extends ConsumerStatefulWidget {
  const SelectStickerPackModal({
    super.key,
    this.initialSelectedPack,
    this.title = 'Sticker Pack',
    this.confirmTitle = 'Simpan Stiker?',
    this.confirmMessage,
    required this.onConfirmSave,
    this.defaultTrayBytes,
  });

  final StickerPack? initialSelectedPack;
  final String title;
  final String confirmTitle;
  final String Function(StickerPack pack)? confirmMessage;
  final Future<bool> Function(StickerPack pack) onConfirmSave;
  final Uint8List? defaultTrayBytes;

  static Future<bool?> show({
    required BuildContext context,
    StickerPack? initialSelectedPack,
    String title = 'Sticker Pack',
    String confirmTitle = 'Simpan Stiker?',
    String Function(StickerPack pack)? confirmMessage,
    required Future<bool> Function(StickerPack pack) onConfirmSave,
    Uint8List? defaultTrayBytes,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: const Color(0xFF111A16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (ctx) => SelectStickerPackModal(
        initialSelectedPack: initialSelectedPack,
        title: title,
        confirmTitle: confirmTitle,
        confirmMessage: confirmMessage,
        onConfirmSave: onConfirmSave,
        defaultTrayBytes: defaultTrayBytes,
      ),
    );
  }

  @override
  ConsumerState<SelectStickerPackModal> createState() =>
      _SelectStickerPackModalState();
}

class _SelectStickerPackModalState
    extends ConsumerState<SelectStickerPackModal> {
  late StickerPack? _selectedPack;

  @override
  void initState() {
    super.initState();
    _selectedPack = widget.initialSelectedPack;
  }

  void _showSnack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontFamily: 'monospace')),
        backgroundColor: isError
            ? const Color(0xFFE53E3E)
            : const Color(0xFF25D366),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 96),
      ),
    );
  }

  void _showConfirmSaveDialog(StickerPack pack) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF111A16),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF25D366).withValues(alpha: 0.15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00FF41).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.save_rounded,
                    color: Color(0xFF00FF41),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.confirmTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.confirmMessage != null
                      ? widget.confirmMessage!(pack)
                      : 'Stiker ini akan disimpan ke pack "${pack.name}"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text(
                          'Batal',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00FF41),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pop(dialogContext);
                          Navigator.pop(context, true);
                          await widget.onConfirmSave(pack);
                        },
                        child: const Text(
                          'Simpan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCreatePackDialog(BuildContext context) {
    final nameController = TextEditingController();
    final publisherController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF111A16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: const Color(0xFF25D366).withValues(alpha: 0.2),
            ),
          ),
          title: const Text(
            'Create Sticker Pack',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Pack Name',
                  labelStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00FF41)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: publisherController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Publisher',
                  labelStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00FF41)),
                  ),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF41),
                foregroundColor: Colors.black,
                minimumSize: const Size(80, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () async {
                final name = nameController.text.trim();
                final publisher = publisherController.text.trim();
                if (name.isEmpty || publisher.isEmpty) {
                  return;
                }
                Navigator.pop(dialogCtx);
                await _onCreateStickerPack(name, publisher);
              },
              child: const Text(
                'Create',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onCreateStickerPack(String name, String publisher) async {
    try {
      Uint8List? trayBytes = widget.defaultTrayBytes;

      if (trayBytes == null) {
        final List<Media> images = await ImagePickers.pickerPaths(
          galleryMode: GalleryMode.image,
          selectCount: 1,
          showCamera: false,
        );
        if (images.isNotEmpty && images.first.path != null) {
          trayBytes = await File(images.first.path!).readAsBytes();
        }
      }

      if (trayBytes == null) {
        _showSnack(
          'Ikon tray diperlukan untuk membuat pack baru',
          isError: true,
        );
        return;
      }

      final trayPath = await ref
          .read(stickerPackProviderProvider.notifier)
          .saveImageTray(trayBytes);
      final identifier = 'stickerify_${DateTime.now().millisecondsSinceEpoch}';

      final newPack = StickerPack(
        identifier: identifier,
        name: name,
        publisher: publisher,
        trayImagePath: trayPath,
        lastEdited: DateTime.now(),
      );

      await ref
          .read(stickerPackProviderProvider.notifier)
          .saveStickerPack(newPack);

      setState(() {
        _selectedPack = newPack;
      });

      _showSnack('Sticker pack berhasil dibuat!');
    } catch (e) {
      _showSnack('Gagal membuat sticker pack: $e', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final packsAsync = ref.watch(stickerPackProviderProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          // Title & Save Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 60), // balance the save button
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              TextButton(
                onPressed: _selectedPack == null
                    ? null
                    : () {
                        if (_selectedPack!.stickers.length >= 30) {
                          _showSnack(
                            'Pack sudah mencapai batas maksimal 30 stiker',
                            isError: true,
                          );
                          return;
                        }
                        _showConfirmSaveDialog(_selectedPack!);
                      },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: _selectedPack != null
                        ? const Color(0xFF00FF41)
                        : Colors.white38,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          packsAsync.when(
            data: (ownedPacks) => _buildPacksGrid(ownedPacks),
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(color: Color(0xFF00FF41)),
              ),
            ),
            error: (err, stack) => Center(
              child: Text(
                'Error: $err',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPacksGrid(List<StickerPack> ownedPacks) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: ownedPacks.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildCreatePackCard();
        }
        final pack = ownedPacks[index - 1];
        final isSelected = _selectedPack?.isarId == pack.isarId;
        return _buildPackCard(pack, isSelected, () {
          setState(() {
            _selectedPack = pack;
          });
        });
      },
    );
  }

  Widget _buildCreatePackCard() {
    return InkWell(
      onTap: () => _showCreatePackDialog(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF16251E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF00FF41).withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, size: 36, color: Color(0xFF00FF41)),
            SizedBox(height: 8),
            Text(
              'Create Sticker Pack',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackCard(StickerPack pack, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF16251E)
                    : const Color(0xFF111A16),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF00FF41)
                      : Colors.white.withValues(alpha: 0.08),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(
                            0xFF00FF41,
                          ).withValues(alpha: 0.15),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: pack.trayImagePath.isNotEmpty
                        ? Image.file(
                            File(pack.trayImagePath),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.collections_bookmark_rounded,
                                  size: 28,
                                  color: Color(0xFF25D366),
                                ),
                          )
                        : const Icon(
                            Icons.collections_bookmark_rounded,
                            size: 28,
                            color: Color(0xFF25D366),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pack.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${pack.stickers.length} Stickers',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF00FF41),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(2),
                child: const Icon(
                  Icons.check_rounded,
                  size: 14,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
