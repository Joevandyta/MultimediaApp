import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
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

  Future<void> saveSticker(StickerModel sticker) async {
    await isar.writeTxn(() async {
      await isar.stickerModels.put(sticker);
    });
  }

  Future<StickerModel> saveStickerBytes(Uint8List bytes) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String stickersPath = '${appDir.path}/saved_stickers';
    final Directory stickersDir = Directory(stickersPath);
    if (!await stickersDir.exists()) {
      await stickersDir.create(recursive: true);
    }

    final String savedStickerId = const Uuid().v4();
    final String filePath = '$stickersPath/sticker_$savedStickerId.png';
    await File(filePath).writeAsBytes(bytes);

    final sticker = StickerModel(
      savedStickerId: savedStickerId,
      imagePath: filePath,
      createdAt: DateTime.now(),
    );

    await saveSticker(sticker);
    return sticker;
  }

  Future<void> deleteSticker(String savedStickerId) async {
    final sticker = await getStickerById(savedStickerId);
    if (sticker != null) {
      try {
        final file = File(sticker.imagePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {}
    }

    await isar.writeTxn(() async {
      await isar.stickerModels
          .filter()
          .savedStickerIdEqualTo(savedStickerId)
          .deleteFirst();
    });
  }

  Future<bool> isStickerSaved(String id) async {
    final sticker = await isar.stickerModels
        .filter()
        .savedStickerIdEqualTo(id)
        .findFirst();
    return sticker != null;
  }
}
