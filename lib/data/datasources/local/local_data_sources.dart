import 'dart:ffi';
import 'dart:typed_data';
import 'package:multimedia_sticker_maker/core/services/Image_file.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:uuid/uuid.dart';
import 'package:isar_community/isar.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';

class LocalDataSource {
  late Isar isar;

  LocalDataSource({required this.isar});

  Future<StickerModel?> getStickerById(String id) async {
    return await isar.stickerModels
        .filter()
        .savedStickerIdEqualTo(id)
        .findFirst();
  }

  Future<List<StickerModel>> getAllStickers() async {
    return await isar.stickerModels.where().findAll();
  }

  Future<StickerModel> saveSticker(Uint8List bytes, extension) async {
    try {
      final fileName = await FileServices().saveImgBytes(
        bytes,
        'stickers',
        extension: extension,
      );
      final String savedStickerId = const Uuid().v4();

      final sticker = StickerModel(
        savedStickerId: savedStickerId,
        imagePath: fileName,
        createdAt: DateTime.now(),
      );

      await isar.writeTxn(() async {
        await isar.stickerModels.put(sticker);
      });
      return sticker;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<StickerModel> updateSticker(
    String savedStickerId,
    Uint8List newBytes,
  ) async {
    try {
      final existing = await isar.stickerModels
          .filter()
          .savedStickerIdEqualTo(savedStickerId)
          .findFirst();

      if (existing == null) throw Exception('Sticker not found');
      final extension = existing.imagePath.split('.').last.toLowerCase();
      // Delete old file then save new one
      await FileServices().removeImgFile(existing.imagePath);
      final newPath = await FileServices().saveImgBytes(
        newBytes,
        'stickers',
        extension: extension,
      );
      final updatedSticker = StickerModel(
        savedStickerId: savedStickerId,
        imagePath: newPath,
        createdAt: existing.createdAt,
      )..isarId = existing.isarId;
      await isar.writeTxn(() async {
        await isar.stickerModels.put(updatedSticker);
      });
      return updatedSticker;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteSticker(String savedStickerId) async {
    final sticker = await getStickerById(savedStickerId);
    if (sticker != null) {
      try {
        await FileServices().removeImgFile(sticker.imagePath);
        await isar.writeTxn(() async {
          await isar.stickerModels
              .filter()
              .savedStickerIdEqualTo(savedStickerId)
              .deleteFirst();
        });
      } catch (_) {}
    }
  }

  Future<bool> isStickerSaved(String id) async {
    final sticker = await isar.stickerModels
        .filter()
        .savedStickerIdEqualTo(id)
        .findFirst();
    return sticker != null;
  }

  Future<void> saveStickerTray(Uint8List bytes) async {
    try {} catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> addStickerToPack({
    required Uint8List imageBytes,
    required String extension,
    required List<String> emoji,
    required int packId,
  }) async {
    try {
      final savedNewSticker = await saveSticker(imageBytes, extension);
      final stickerPack = await getStickerPackById(packId);
      if (stickerPack == null) {
        throw Exception("Sticker pack not found");
      }
      stickerPack.addSticker(savedNewSticker, emoji);
      stickerPack.lastEdited = DateTime.now();
      await saveStickerPack(stickerPack);

      return savedNewSticker.savedStickerId;
    } catch (e) {
      print("Error adding sticker to pack: $e");
      throw Exception("cant add new sticker to pack ${e.toString()}");
    }
  }

  Future<String> updateStickerInPack({
    required Uint8List newImageBytes,
    required List<String> emoji,
    required int packId,
    required String savedStickerId,
  }) async {
    try {
      final updatedSticker = await updateSticker(savedStickerId, newImageBytes);
      final sticker = await getStickerById(savedStickerId);
      if (sticker != null) {
        throw Exception("Sticker not found");
      }
      final stickerPack = await getStickerPackById(packId);
      if (stickerPack == null) {
        throw Exception("Sticker pack not found");
      }
      stickerPack.removeSticker(sticker!);
      stickerPack.addSticker(updatedSticker, emoji);
      stickerPack.lastEdited = DateTime.now();
      await saveStickerPack(stickerPack);

      return updatedSticker.savedStickerId;
    } catch (e) {
      print("Error adding sticker to pack: $e");
      throw Exception("cant add new sticker to pack ${e.toString()}");
    }
  }

  Future<void> removeStickerFromPack(String savedStickerId, int packId) async {
    try {
      print("remove sticker from pack");
      final stickerPack = await getStickerPackById(packId);
      if (stickerPack == null) {
        throw Exception("Sticker pack not found");
      }

      final sticker = await getStickerById(savedStickerId);
      if (sticker == null) {
        throw Exception("Sticker not found");
      }
      deleteSticker(savedStickerId);
      stickerPack.lastEdited = DateTime.now();
      stickerPack.removeSticker(sticker);
      await saveStickerPack(stickerPack);
    } catch (e) {
      throw Exception("cant remove sticker from pack ${e.toString()}");
    }
  }

  Future<void> saveStickerPack(StickerPack stickerPack) async {
    try {
      await isar.writeTxn(() async {
        await isar.stickerPacks.put(stickerPack);
        await stickerPack.stickers.save();
      });
      print('Sticker pack saved successfully in local source');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<StickerPack?> getStickerPackById(int id) async {
    final stickerPack = await isar.stickerPacks
        .filter()
        .isarIdEqualTo(id)
        .findFirst();
    if (stickerPack == null) return null;
    await stickerPack.stickers.load();
    return stickerPack;
  }

  Future<List<StickerPack>> getStickerPacks() async {
    print("get all sticker pack");
    final list = await isar.stickerPacks.where().findAll();
    for (final pack in list) {
      await pack.stickers.load();
    }
    print("sticker pack : ${list.length}");
    return list;
  }

  Future<List<StickerModel>> getAllStickersInStickerPack({
    required int packId,
  }) async {
    final stickerPack = await isar.stickerPacks
        .filter()
        .isarIdEqualTo(packId)
        .findFirst();
    if (stickerPack == null) return [];
    await stickerPack.stickers.load();
    List<StickerModel> list = stickerPack.stickers.toList();
    return list;
  }

  Future<void> deleteStickerPack(int id) async {
    await isar.writeTxn(() async {
      await isar.stickerPacks.filter().isarIdEqualTo(id).deleteFirst();
    });
  }
}
