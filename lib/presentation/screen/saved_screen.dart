import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/sticker_provider.dart';
import '../../data/models/sticker_model.dart';

class SavedScreen extends ConsumerStatefulWidget {
  const SavedScreen({super.key});

  @override
  ConsumerState<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends ConsumerState<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    final savedStickersAsync = ref.watch(savedStickersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Stickers')),
      body: savedStickersAsync.when(
        data: (savedStickers) => savedStickers.isEmpty
            ? _buildEmptyState()
            : _buildGrid(savedStickers),
        loading: () => const Center(child: CircularProgressIndicator()),
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
            Icons.collections_outlined,
            size: 64,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada stiker yang disimpan',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<StickerModel> savedStickers) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: savedStickers.length,
      itemBuilder: (context, index) {
        final sticker = savedStickers[index];
        return GestureDetector(
          onTap: () {
            context.push('/editor', extra: sticker);
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete Sticker'),
                  content: const Text(
                    'Are you sure you want to delete this sticker?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(savedStickersProvider.notifier)
                            .removeSticker(sticker.savedStickerId);
                        Navigator.pop(context);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );
          },
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
      },
    );
  }
}
