import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:multimedia_sticker_maker/core/services/Image_file.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:multimedia_sticker_maker/data/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sticker_pack_provider.g.dart';

@riverpod
class StickerPackProvider extends _$StickerPackProvider {
  @override
  FutureOr<List<StickerPack>> build() async {
    // Menggunakan repository untuk mengambil data
    final usecase = await ref.watch(stickerUseCaseProvider.future);
    return await usecase.getAllStickerPacks();
  }

  Future<String> saveImageTray(Uint8List bytes) {
    final path = FileServices().saveImgBytes(bytes, 'tray');
    return path;
  }

  Future<void> saveStickerPack(StickerPack stickerPack) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    await usecase.saveStickerPack(stickerPack);
    print('Sticker added to pack ${stickerPack.getMapStickers()}');
    if (ref.mounted) ref.invalidateSelf();
  }

  Future<String> addStickerToPack({
    required Uint8List bytes,
    required String extension,
    required List<String> emoji,
    required int packId,
  }) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    final stickerId = await usecase.addStickerToPack(
      imageBytes: bytes,
      extension: extension,
      emoji: emoji,
      packId: packId,
    );
    if (ref.mounted) ref.invalidateSelf();
    return stickerId;
  }

  Future<String> updateStickerInPack({
    required Uint8List newImageBytes,
    required List<String> emoji,
    required int packId,
    required String savedStickerId,
  }) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    final stickerId = await usecase.updateStickerInPack(
      newImageBytes: newImageBytes,
      emoji: emoji,
      packId: packId,
      savedStickerId: savedStickerId,
    );
    if (ref.mounted) ref.invalidateSelf();
    return stickerId;
  }

  Future<void> removeStickerFromPack(String savedStickerId, int packId) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    await usecase.removeStickerFromPack(savedStickerId, packId);
    if (ref.mounted) ref.invalidateSelf();
  }

  Future<void> deleteStickerPack(int packId) async {
    final usecase = await ref.read(stickerUseCaseProvider.future);
    await usecase.deleteStickerPack(packId);
    if (ref.mounted) ref.invalidateSelf();
  }

  Future<void> deletePack(StickerPack pack) async {
    await deleteStickerPack(pack.isarId);
  }
}
