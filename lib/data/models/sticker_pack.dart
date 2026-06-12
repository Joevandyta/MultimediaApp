import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';
import 'package:whatsapp_stickers_injector/whatsapp_stickers.dart';

part 'sticker_pack.g.dart';

@collection
class StickerPack {
  Id isarId = Isar.autoIncrement;
  final Map<String, List<String>> _stickers = {};
  final String identifier;
  final String name;
  final String publisher;
  final String trayImagePath;
  String? publisherWebsite;
  String? privacyPolicyWebsite;
  String? licenseAgreementWebsite;

  StickerPack({
    required this.identifier,
    required this.name,
    required this.publisher,
    required this.trayImagePath,
    this.publisherWebsite,
    this.privacyPolicyWebsite,
    this.licenseAgreementWebsite,
  });

  void addSticker(StickerModel sticker, List<String> emojis) {
    _stickers[sticker.imagePath] = emojis;
  }

  void removeSticker(StickerModel sticker) {
    _stickers.remove(sticker.imagePath);
  }

  void removeAllStickers() {
    _stickers.clear();
  }

  Future<void> shareToWhatsApp() async {
    try {
      final whatsappStickers = WhatsappStickers(
        identifier: identifier,
        name: name,
        publisher: publisher,
        trayImageFileName: WhatsappStickerImage.fromFile(
          trayImagePath,
        ),
        publisherWebsite: publisherWebsite,
        privacyPolicyWebsite: privacyPolicyWebsite,
        licenseAgreementWebsite: licenseAgreementWebsite,
      );
      _stickers.forEach((path, emojis) {
        whatsappStickers.addSticker(
          WhatsappStickerImage.fromFile(path),
          emojis,
        );
      });
      await whatsappStickers.sendToWhatsApp();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
