import 'dart:typed_data';

import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';
import 'package:multimedia_sticker_maker/domain/repositories/sticker_repository.dart';

class StickerUseCase {
  final StickerRepository repository;

  StickerUseCase({required this.repository});

  Future<StickerModel?> getStickerById(String id) {
    return repository.getStickerById(id);
  }

  Future<List<StickerModel>> getSavedStickers() {
    return repository.getSavedStickers();
  }

  Future<StickerModel> saveSticker(Uint8List bytes, String extension) {
    return repository.saveSticker(bytes, extension);
  }

  Future<void> updateSticker(String savedStickerId, Uint8List bytes) {
    return repository.updateSticker(savedStickerId, bytes);
  }

  Future<void> deleteSticker(String savedStickerId) {
    return repository.deleteSticker(savedStickerId);
  }

  Future<bool> isStickerSaved(String id) {
    return repository.isStickerSaved(id);
  }
}
