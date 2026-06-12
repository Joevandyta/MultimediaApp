import 'dart:typed_data';
import 'package:multimedia_sticker_maker/core/services/Image_file.dart';
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

  Future<void> updateSticker(
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

      await isar.writeTxn(() async {
        await isar.stickerModels.put(
          StickerModel(
            savedStickerId: savedStickerId,
            imagePath: newPath,
            createdAt: existing.createdAt,
          )..isarId = existing.isarId,
        );
      });
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
    try {
      final fileName = await FileServices().saveImgBytes(
        bytes,
        'tray',
        extension: 'png',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  // FuturesaveStickerPack(StickerPackModel pack) async {
  //   await isar.writeTxn(() async {
  //     await isar.stickerPackModels.put(pack);
  //   });
  // }

  // Future<List<StickerPackModel>> getAllStickerPacks() async {
  //   return await isar.stickerPackModels.where().findAll();
  // }

  // Future deleteStickerPack(String identifier) async {
  //   await isar.writeTxn(() async {
  //     await isar.stickerPackModels
  //         .filter()
  //         .identifierEqualTo(identifier)
  //         .deleteFirst();
  //   });
  // }
}
