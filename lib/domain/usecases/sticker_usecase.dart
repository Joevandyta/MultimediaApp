import 'dart:typed_data';

import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';

abstract class StickerUseCase {
  Future<StickerModel?> getStickerById(String id);
  Future<List<StickerModel>> getSavedStickers();
  Future<StickerModel> saveSticker(Uint8List bytes, String extension);
  Future<void> updateSticker(String savedStickerId, Uint8List bytes);
  Future<void> deleteSticker(String savedStickerId);
  Future<bool> isStickerSaved(String savedStickerId);
  Future saveStickerPack(StickerPack stickerPack);
  Future<StickerPack?> getStickerPackById(int packId);
  Future deleteStickerPack(int id);
  Future<String> addStickerToPack({
    required Uint8List imageBytes,
    required String extension,
    required List<String> emoji,
    required int packId,
  });
  Future removeStickerFromPack(String savedStickerId, int packId);
  Future<String> updateStickerInPack({
    required Uint8List newImageBytes,
    required List<String> emoji,
    required int packId,
    required String savedStickerId,
  });
  Future<List<StickerPack>> getAllStickerPacks();
  Future<List<StickerModel>> getAllStickersInStickerPack({required int packId});
}
