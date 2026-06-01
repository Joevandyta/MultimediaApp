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

  Future<StickerModel> saveNewSticker(Uint8List bytes) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    final sticker = await usecase.saveStickerBytes(bytes);
    ref.invalidateSelf();
    return sticker;
  }

  Future<void> toggleSaved(StickerModel sticker) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    final isSaved = await usecase.isStickerSaved(sticker.savedStickerId);

    if (isSaved) {
      await usecase.deleteSticker(sticker.savedStickerId);
    } else {
      await usecase.saveSticker(sticker);
    }

    ref.invalidateSelf();
  }

  Future<void> removeSticker(String savedStickerId) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);

    await usecase.deleteSticker(savedStickerId);

    final currentState = state.value ?? [];
    state = AsyncData(
      currentState.where((s) => s.savedStickerId != savedStickerId).toList(),
    );
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
