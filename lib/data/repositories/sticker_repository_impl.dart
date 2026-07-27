import 'dart:typed_data';

import 'package:multimedia_sticker_maker/data/datasources/local/local_data_sources.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';

import '../../domain/repositories/sticker_repository.dart';
import '../models/sticker_model.dart';

class StickerRepositoryImpl implements StickerRepository {
  StickerRepositoryImpl({required this.localDataSource});

  final LocalDataSource localDataSource;

  @override
  Future<StickerModel?> getStickerById(String id) async {
    return await localDataSource.getStickerById(id);
  }

  @override
  Future<List<StickerModel>> getSavedStickers() async {
    return await localDataSource.getAllStickers();
  }

  @override
  Future<StickerModel> saveSticker(Uint8List bytes, String extension) async {
    return await localDataSource.saveSticker(bytes, extension);
  }

  @override
  Future<void> updateSticker(String savedStickerId, Uint8List bytes) async {
    await localDataSource.updateSticker(savedStickerId, bytes);
  }

  @override
  Future<void> deleteSticker(String savedStickerId) async {
    await localDataSource.deleteSticker(savedStickerId);
  }

  @override
  Future<bool> isStickerSaved(String savedStickerId) async {
    return await localDataSource.isStickerSaved(savedStickerId);
  }

  @override
  Future<void> saveStickerPack(StickerPack stickerPack) async {
    await localDataSource.saveStickerPack(stickerPack);
  }

  @override
  Future<StickerPack?> getStickerPackById(int packId) {
    return localDataSource.getStickerPackById(packId);
  }

  @override
  Future<String> addStickerToPack({
    required Uint8List imageBytes,
    required String extension,
    required List<String> emoji,
    required int packId,
  }) async {
    return await localDataSource.addStickerToPack(
      imageBytes: imageBytes,
      extension: extension,
      emoji: emoji,
      packId: packId,
    );
  }

  @override
  Future<dynamic> deleteStickerPack(int packId) async {
    await localDataSource.deleteStickerPack(packId);
  }

  @override
  Future<List<StickerPack>> getAllStickerPacks() async {
    return await localDataSource.getStickerPacks();
  }

  @override
  Future<String> updateStickerInPack({
    required Uint8List newImageBytes,
    required List<String> emoji,
    required int packId,
    required String savedStickerId,
  }) {
    return localDataSource.updateStickerInPack(
      newImageBytes: newImageBytes,
      emoji: emoji,
      packId: packId,
      savedStickerId: savedStickerId,
    );
  }

  @override
  Future<dynamic> removeStickerFromPack(
    String savedStickerId,
    int packId,
  ) async {
    await localDataSource.removeStickerFromPack(savedStickerId, packId);
  }

  @override
  Future<List<StickerModel>> getAllStickersInStickerPack({
    required int packId,
  }) {
    return localDataSource.getAllStickersInStickerPack(packId: packId);
  }
}
