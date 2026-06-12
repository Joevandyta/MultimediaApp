import 'dart:typed_data';

import 'package:multimedia_sticker_maker/data/datasources/local/local_data_sources.dart';

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
}
