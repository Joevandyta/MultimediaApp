import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:multimedia_sticker_maker/core/services/Image_file.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_stickers_injector/exceptions.dart';
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

  void addSticker(StickerModel sticker, [List<String>? emojis]) {
    final alreadyExists = stickers.any(
      (s) => s.savedStickerId == sticker.savedStickerId,
    );
    if (!alreadyExists) {
      if (emojis != null && emojis.isNotEmpty) {
        sticker.emojis = emojis;
      }
      stickers.add(sticker);
      if (kDebugMode) {
        debugPrint("sticker added ${sticker.emojis} ${sticker.imagePath}");
      }
    }
  }

  void removeSticker(StickerModel sticker) {
    final list = stickers.toList();
    final index = list.indexWhere(
      (s) =>
          s.savedStickerId == sticker.savedStickerId ||
          s.imagePath == sticker.imagePath,
    );
    if (index != -1) {
      stickers.remove(list[index]);
      lastEdited = DateTime.now();
    }
  }

  void removeAllStickers() {
    stickers.clear();
    lastEdited = DateTime.now();
  }

  List<MapEntry<String, List<String>>> getMapStickers() {
    return stickers.map((s) => MapEntry(s.imagePath, s.emojis)).toList();
  }

  Future<void> shareToWhatsApp() async {
    if (kDebugMode) {
      debugPrint("=== Share Pack: $name ($identifier) ===");
    }
    try {
      // [Fix #4] IsarLinks bersifat lazy — harus di-load() dahulu sebelum toList()
      await stickers.load();

      if (stickers.length < 3) {
        throw Exception(
          'Sticker pack harus memiliki minimal 3 sticker (saat ini: ${stickers.length})',
        );
      }
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

      final paddedTray = img.Image(
        width: traySize,
        height: traySize,
        numChannels: 4,
      );
      final offsetX = (traySize - decodedTray.width) ~/ 2;
      final offsetY = (traySize - decodedTray.height) ~/ 2;

      img.compositeImage(paddedTray, decodedTray, dstX: offsetX, dstY: offsetY);

      final resizedTray = img.copyResize(paddedTray, width: 96, height: 96);

      // Center the original image on the canvas

      final safeName = name
          .trim()
          .replaceAll(RegExp(r'\s+'), '_')
          .replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '');
      final trayPath = '${stickersDirectory.path}/tray_$safeName.png';
      await File(trayPath).writeAsBytes(img.encodePng(resizedTray));

      if (kDebugMode) {
        final trayFileSize = await File(trayPath).length();
        debugPrint(
          "Tray -> path: $trayPath | size: ${trayFileSize}B | dimensions: ${resizedTray.width}x${resizedTray.height} (original: ${decodedTray.width}x${decodedTray.height})",
        );
      }

      final whatsappStickers = WhatsappStickers(
        identifier: identifier,
        name: name,
        publisher: publisher,
        trayImageFileName: WhatsappStickerImage.fromFile(trayPath),
        publisherWebsite: "",
        privacyPolicyWebsite: "",
        licenseAgreementWebsite: "",
      );

      final stickersList = stickers.toList();
      if (kDebugMode) {
        debugPrint(
          "Total stickers in pack: ${stickersList.length} (loaded via IsarLinks)",
        );
      }

      await Future.forEach(stickersList, (sticker) async {
        final webp = await FileServices().temporaryWebp(
          sticker.imagePath,
          sticker.isarId.toString(),
        );
        final stickerEmojis = sticker.emojis.isNotEmpty
            ? sticker.emojis
            : ['😢', '😭'];

        whatsappStickers.addSticker(
          WhatsappStickerImage.fromFile(webp.path),
          stickerEmojis,
        );
      });

      // for (var i = 0; i < stickersList.length; i++) {
      //   final sticker = stickersList[i];

      //   if (kDebugMode) {
      //     final originalFile = File(sticker.imagePath);
      //     final originalExists = await originalFile.exists();
      //     final originalSize = originalExists
      //         ? await originalFile.length()
      //         : -1;
      //     debugPrint(
      //       "[$i] savedStickerId: ${sticker.savedStickerId} | "
      //       "original path: ${sticker.imagePath} | "
      //       "exists: $originalExists | "
      //       "original size: ${originalSize}B | "
      //       "emojis (raw): ${sticker.emojis}",
      //     );
      //   }

      //   final webpImg = await FileServices().temporaryWebp(
      //     sticker.imagePath,
      //     sticker.isarId.toString(),
      //   );
      //   final webpPath = webpImg.path;

      //   final stickerEmojis = sticker.emojis.isNotEmpty
      //       ? sticker.emojis
      //       : ['😢', '😭'];

      //   if (kDebugMode) {
      //     final webpFile = File(webpPath);
      //     final webpExists = await webpFile.exists();
      //     final webpSize = webpExists ? await webpFile.length() : -1;
      //     final decodedWebp = webpExists
      //         ? img.decodeImage(await webpFile.readAsBytes())
      //         : null;
      //     debugPrint(
      //       "[$i] webp path: $webpPath | "
      //       "size: ${webpSize}B ${webpSize > 100000 ? '⚠️ OVER 100KB LIMIT' : ''} | "
      //       "dimensions: ${decodedWebp?.width}x${decodedWebp?.height} "
      //       "${(decodedWebp != null && (decodedWebp.width != 512 || decodedWebp.height != 512)) ? '⚠️ NOT 512x512' : ''} | "
      //       "emojis used: $stickerEmojis "
      //       "${stickerEmojis.isEmpty ? '⚠️ EMPTY EMOJIS' : ''}",
      //     );
      //   }

      //   whatsappStickers.addSticker(
      //     WhatsappStickerImage.fromFile(webpPath),
      //     ['😢', '😭'],
      //   );
      // }

      try {
        await whatsappStickers.sendToWhatsApp();
      } on WhatsappStickersException catch (e) {
        if (kDebugMode) {
          debugPrint("Error sending sticker pack to WhatsApp: $e");
        }
        throw Exception(e.cause);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error sending sticker pack to WhatsApp: $e");
      }
      throw Exception(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'name': name,
      'publisher': publisher,
      'trayImagePath': trayImagePath,
      'publisherWebsite': publisherWebsite,
      'privacyPolicyWebsite': privacyPolicyWebsite,
      'licenseAgreementWebsite': licenseAgreementWebsite,
      'lastEdited': lastEdited.toIso8601String(),
      'stickers': stickers.toList().map((s) => s.toJson()).toList(),
    };
  }
}
