import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';

part 'sticker_model.g.dart';

@collection
class StickerModel {
  Id isarId = Isar.autoIncrement;
  final String savedStickerId;
  final String imagePath;
  final DateTime createdAt;

  @Backlink(to: 'stickers')
  final pack = IsarLink<StickerPack>();

  StickerModel({
    required this.savedStickerId,
    required this.imagePath,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'savedStickerId': savedStickerId,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory StickerModel.fromJson(Map<String, dynamic> json) {
    return StickerModel(
      savedStickerId: json['savedStickerId'],
      imagePath: json['imagePath'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  factory StickerModel.fromFile(File file) {
    return StickerModel(
      savedStickerId: file.path,
      imagePath: file.path,
      createdAt: DateTime.now(),
    );
  }
}
