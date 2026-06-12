import 'dart:typed_data';
import '../../data/models/sticker_model.dart';

abstract class StickerRepository {
  Future<StickerModel?> getStickerById(String id);
  Future<List<StickerModel>> getSavedStickers();
  Future<StickerModel> saveSticker(Uint8List bytes, String extension);
  Future<void> updateSticker(String savedStickerId, Uint8List bytes);
  Future<void> deleteSticker(String savedStickerId);
  Future<bool> isStickerSaved(String savedStickerId);
}
