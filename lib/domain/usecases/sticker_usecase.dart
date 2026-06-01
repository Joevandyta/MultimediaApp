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

  Future<StickerModel> saveStickerBytes(Uint8List bytes) {
    return repository.saveStickerBytes(bytes);
  }

  Future<void> saveSticker(StickerModel sticker) {
    return repository.saveSticker(sticker);
  }

  Future<void> deleteSticker(String id) {
    return repository.deleteSticker(id);
  }

  Future<bool> isStickerSaved(String id) {
    return repository.isStickerSaved(id);
  }
}
