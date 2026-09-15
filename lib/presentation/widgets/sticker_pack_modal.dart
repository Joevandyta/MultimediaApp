import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multimedia_sticker_maker/core/constants/constants.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';

/// Convenience function — screens call this instead of wiring up
/// [showModalBottomSheet] themselves.
void showStickerPackModal({
  required BuildContext context,
  required StickerPack pack,
  required VoidCallback onShare,
}) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    backgroundColor: const Color(0xFF111A16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    isScrollControlled: true,
    builder: (_) => StickerPackModalSheet(pack: pack, onShare: onShare),
  );
}

class StickerPackModalSheet extends StatelessWidget {
  final StickerPack pack;
  final VoidCallback onShare;

  const StickerPackModalSheet({
    super.key,
    required this.pack,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final stickersList = pack.stickers.toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pack.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Oleh ${pack.publisher}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white12, height: 24),
              // Stickers grid
              Expanded(
                child: stickersList.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada stiker di paket ini',
                          style: TextStyle(color: Colors.white38),
                        ),
                      )
                    : GridView.builder(
                        controller: scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1,
                            ),
                        itemCount: stickersList.length,
                        itemBuilder: (context, index) {
                          final sticker = stickersList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              context.push(
                                AppRoutes.stickerEditorPath(
                                  pack.isarId.toString(),
                                  sticker.savedStickerId,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                                image: DecorationImage(
                                  image: FileImage(File(sticker.imagePath)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 16),

              // Share to WhatsApp button
              ElevatedButton(
                onPressed: stickersList.length < 3
                    ? null
                    : () {
                        Navigator.pop(context);
                        onShare();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white10,
                  disabledForegroundColor: Colors.white30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_rounded),
                    const SizedBox(width: 8),
                    Text(
                      stickersList.length < 3
                          ? 'Minimal 3 Stiker untuk WhatsApp'
                          : 'Tambahkan ke WhatsApp',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
