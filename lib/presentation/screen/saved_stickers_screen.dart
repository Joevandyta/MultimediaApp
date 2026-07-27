import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/sticker_provider.dart';
import '../../data/models/sticker_model.dart';

class SavedStickersScreen extends ConsumerStatefulWidget {
  const SavedStickersScreen({super.key});

  @override
  ConsumerState<SavedStickersScreen> createState() =>
      _SavedStickersScreenState();
}

class _SavedStickersScreenState extends ConsumerState<SavedStickersScreen> {
  @override
  Widget build(BuildContext context) {
    final savedStickersAsync = ref.watch(savedStickersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stiker Tersimpan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: savedStickersAsync.when(
        data: (savedStickers) => savedStickers.isEmpty
            ? _buildEmptyState()
            : _buildGrid(savedStickers),
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
            Icons.collections_outlined,
            size: 64,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada stiker yang disimpan',
            style: TextStyle(color: Colors.white70, fontSize: 15),
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
                  backgroundColor: const Color(0xFF111A16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: const Color(0xFF25D366).withValues(alpha: 0.2),
                    ),
                  ),
                  title: const Text(
                    'Hapus Stiker?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    'Apakah Anda yakin ingin menghapus stiker ini dari penyimpanan?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Batal',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
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
                      onPressed: () {
                        ref
                            .read(savedStickersProvider.notifier)
                            .removeSticker(sticker.savedStickerId);
                        Navigator.pop(context);
                      },
                      child: const Text('Hapus'),
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
