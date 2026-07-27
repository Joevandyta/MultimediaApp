import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:multimedia_sticker_maker/core/services/Image_file.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_stickers_injector/whatsapp_stickers.dart';
import 'package:image/image.dart' as img;
part 'sticker_pack.g.dart';

@collection
class StickerPack {
  Id isarId = Isar.autoIncrement;
  final String identifier;
  final String name;
  final String publisher;
  final String trayImagePath;
  String? publisherWebsite;
  String? privacyPolicyWebsite;
  String? licenseAgreementWebsite;
  DateTime lastEdited;

  final stickers = IsarLinks<StickerModel>();

  List<String> stickerEmojis = <String>[];

  StickerPack({
    required this.identifier,
    required this.name,
    required this.publisher,
    required this.trayImagePath,
    this.publisherWebsite,
    this.privacyPolicyWebsite,
    this.licenseAgreementWebsite,
    required this.lastEdited,
  });

  void addSticker(StickerModel sticker, List<String> emojis) {
    print("Sticker ${sticker.savedStickerId}");
    final alreadyExists = stickers.any(
      (s) => s.savedStickerId == sticker.savedStickerId,
    );
    print("Already Exists: ${alreadyExists}");
    print("Stickers Count: ${stickers.length}");
    if (!alreadyExists) {
      stickers.add(sticker);
      stickerEmojis = List<String>.from(stickerEmojis)..add(emojis.join(','));
    }
  }

  void removeSticker(StickerModel sticker) {
    final list = stickers.toList();
    final index = list.indexWhere((s) => s.imagePath == sticker.imagePath);
    if (index != -1) {
      stickers.remove(sticker);
      stickerEmojis = List<String>.from(stickerEmojis)..removeAt(index);
      lastEdited = DateTime.now();
    }
  }

  void removeAllStickers() {
    stickers.clear();
    stickerEmojis = <String>[];
    lastEdited = DateTime.now();
  }

  List<MapEntry<String, List<String>>> getMapStickers() {
    final list = stickers.toList();
    return List.generate(list.length, (i) {
      return MapEntry(list[i].imagePath, stickerEmojis[i].split(','));
    });
  }

  Future<void> shareToWhatsApp() async {
    try {
      final appDir = await getTemporaryDirectory();

      final stickersDirectory = Directory('${appDir.path}/stickers');
      await stickersDirectory.create(recursive: true);

      final trayBytes = await File(trayImagePath).readAsBytes();
      final decodedTray = img.decodeImage(trayBytes);
      if (decodedTray == null) {
        throw Exception('Failed to decode tray image');
      }
      final traySize = decodedTray.width > decodedTray.height
          ? decodedTray.width
          : decodedTray.height;

      final paddedTray = img.Image(width: traySize, height: traySize);

      final offsetX = (traySize - decodedTray.width) ~/ 2;
      final offsetY = (traySize - decodedTray.height) ~/ 2;

      img.compositeImage(paddedTray, decodedTray, dstX: offsetX, dstY: offsetY);

      final resizedTray = img.copyResize(paddedTray, width: 96, height: 96);

      // Center the original image on the canvas
      final trayPath = '${stickersDirectory.path}/tray_$name.png';

      await File(trayPath).writeAsBytes(img.encodePng(resizedTray));

      final whatsappStickers = WhatsappStickers(
        identifier: identifier,
        name: name,
        publisher: publisher,
        trayImageFileName: WhatsappStickerImage.fromFile(trayPath),
        publisherWebsite: publisherWebsite,
        privacyPolicyWebsite: privacyPolicyWebsite,
        licenseAgreementWebsite: licenseAgreementWebsite,
      );

      final stickersList = stickers.toList();
      for (final sticker in stickersList) {
        final webpPath = await FileServices().temporaryWebp(
          sticker.imagePath,
          sticker.savedStickerId,
        );
        print("Webp Path: $webpPath");
        whatsappStickers.addSticker(
          WhatsappStickerImage.fromFile(webpPath),
          stickerEmojis[stickersList.indexOf(sticker)].split(','),
        );
      }

      await whatsappStickers.sendToWhatsApp();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
