import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:uuid/uuid.dart';

part 'sticker_model.g.dart';

@collection
class StickerModel {
  Id isarId = Isar.autoIncrement;
  final String savedStickerId;
  final String imagePath;
  final DateTime createdAt;

  List<String> emojis = <String>[];

  @Backlink(to: 'stickers')
  final pack = IsarLink<StickerPack>();

  StickerModel({
    required this.savedStickerId,
    required this.imagePath,
    required this.createdAt,
    this.emojis = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'savedStickerId': savedStickerId,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
      'emojis': emojis,
    };
  }

  factory StickerModel.fromJson(Map<String, dynamic> json) {
    return StickerModel(
      savedStickerId: json['savedStickerId'],
      imagePath: json['imagePath'],
      createdAt: DateTime.parse(json['createdAt']),
      emojis:
          (json['emojis'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  factory StickerModel.fromFile(File file, {List<String> emojis = const []}) {
    return StickerModel(
      savedStickerId: const Uuid().v4(),
      imagePath: file.path,
      createdAt: DateTime.now(),
      emojis: emojis,
    );
  }
}
