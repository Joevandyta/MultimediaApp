import 'dart:typed_data';
import '../../data/models/sticker_model.dart';

abstract class StickerRepository {
  Future<StickerModel?> getStickerById(String id);
  Future<List<StickerModel>> getSavedStickers();
  Future<StickerModel> saveStickerBytes(Uint8List bytes);
  Future<void> saveSticker(StickerModel sticker);
  Future<void> deleteSticker(String id);
  Future<bool> isStickerSaved(String savedStickerId);
}
