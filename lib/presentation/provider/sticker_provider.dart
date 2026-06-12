import 'dart:typed_data';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/sticker_model.dart';
import '../../data/repository_providers.dart';

part 'sticker_provider.g.dart';

// Provider untuk Repository

@riverpod
class SavedStickers extends _$SavedStickers {
  @override
  FutureOr<List<StickerModel>> build() async {
    // Menggunakan repository untuk mengambil data
    final usecase = await ref.watch(stickerUseCaseProvider.future);
    return await usecase.getSavedStickers();
  }

  Future<StickerModel?> getStickerById(String id) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    return await usecase.getStickerById(id);
  }

  Future<StickerModel> saveNewSticker(Uint8List bytes, String extension) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    final sticker = await usecase.saveSticker(bytes, extension);
    if (ref.mounted) ref.invalidateSelf(); 
    return sticker;
  }

  Future<void> updateSticker(String savedStickerId, Uint8List bytes) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    await usecase.updateSticker(savedStickerId, bytes);
    if (ref.mounted) ref.invalidateSelf(); 
  }

  Future<void> removeSticker(String savedStickerId) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);

    await usecase.deleteSticker(savedStickerId);
    if (ref.mounted) ref.invalidateSelf(); 
  }
}

@riverpod
bool isSaved(Ref ref, String savedStickerId) {
  final savedAsync = ref.watch(savedStickersProvider);
  return savedAsync.when(
    data: (list) => list.any((s) => s.savedStickerId == savedStickerId),
    loading: () => false,
    error: (_, _) => false,
  );
}