import 'dart:typed_data';

import 'package:multimedia_sticker_maker/data/models/remote/api_stickers_response_dto.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:multimedia_sticker_maker/domain/repositories/sticker_repository.dart';
import 'package:multimedia_sticker_maker/domain/usecases/sticker_usecase.dart';

class StickerUseCaseImpl implements StickerUseCase {
  final StickerRepository repository;

  StickerUseCaseImpl({required this.repository});

  @override
  Future<StickerModel?> getStickerById(String id) {
    return repository.getStickerById(id);
  }

  @override
  Future<List<StickerModel>> getSavedStickers() {
    return repository.getSavedStickers();
  }

  @override
  Future<StickerModel> saveSticker(Uint8List bytes, String extension) {
    return repository.saveSticker(bytes, extension);
  }

  @override
  Future<void> updateSticker(String savedStickerId, Uint8List bytes) {
    return repository.updateSticker(savedStickerId, bytes);
  }

  @override
  Future<void> deleteSticker(String savedStickerId) {
    return repository.deleteSticker(savedStickerId);
  }

  @override
  Future<bool> isStickerSaved(String id) {
    return repository.isStickerSaved(id);
  }

  // sticker pack
  @override
  Future saveStickerPack(StickerPack stickerPack) {
    return repository.saveStickerPack(stickerPack);
  }

  @override
  Future<StickerPack?> getStickerPackById(int packId) {
    return repository.getStickerPackById(packId);
  }

  @override
  Future<List<StickerPack>> getAllStickerPacks() {
    return repository.getAllStickerPacks();
  }

  @override
  Future<String> addStickerToPack({
    required Uint8List imageBytes,
    required String extension,
    required List<String> emoji,
    required int packId,
  }) {
    return repository.addStickerToPack(
      imageBytes: imageBytes,
      extension: extension,
      emoji: emoji,
      packId: packId,
    );
  }

  @override
  Future<dynamic> deleteStickerPack(int packId) {
    return repository.deleteStickerPack(packId);
  }

  @override
  Future<String> updateStickerInPack({
    required Uint8List newImageBytes,
    required List<String> emoji,
    required int packId,
    required String savedStickerId,
  }) {
    return repository.updateStickerInPack(
      newImageBytes: newImageBytes,
      emoji: emoji,
      packId: packId,
      savedStickerId: savedStickerId,
    );
  }

  @override
  Future<dynamic> removeStickerFromPack(String savedStickerId, int packId) {
    return repository.removeStickerFromPack(savedStickerId, packId);
  }

  @override
  Future<List<StickerModel>> getAllStickersInStickerPack({
    required int packId,
  }) {
    return repository.getAllStickersInStickerPack(packId: packId);
  }

  @override
  Future<ApiStickersResponseDto> searchStickers({
    required String search,
    required int page,
    required int limit,
  }) {
    return repository.searchStickers(search: search, page: page, limit: limit);
  }
}
