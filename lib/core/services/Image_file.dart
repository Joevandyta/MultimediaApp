import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FileServices {
  Future<String> saveImgBytes(
    Uint8List bytes,
    String fileCode, {
    extension = 'png',
  }) async {
    final appDir = await getApplicationDocumentsDirectory();
    final stickersDirectory = Directory('${appDir.path}/$fileCode');
    await stickersDirectory.create(recursive: true);
    final String savedStickerId = const Uuid().v4();
    final String filePath =
        '${stickersDirectory.path}/$savedStickerId.$extension';

    await File(filePath).writeAsBytes(bytes);

    return filePath;
  }

  Future<XFile> temporaryWebp(String originalPath, String id) async {
    final appDir = await getTemporaryDirectory();

    final tempDirectory = Directory('${appDir.path}/stickers');
    await tempDirectory.create(recursive: true);

    final String tempFilePath = '${tempDirectory.path}/tempwebp-$id.webp';

    final bytes = await File(originalPath).readAsBytes();

    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw Exception('Failed to decode image');
    }

    final size = decoded.width > decoded.height
        ? decoded.width
        : decoded.height;

    final padded = img.Image(width: size, height: size, numChannels: 4);

    final offsetX = (size - decoded.width) ~/ 2;
    final offsetY = (size - decoded.height) ~/ 2;

    img.compositeImage(padded, decoded, dstX: offsetX, dstY: offsetY);

    final tempPng = File('${tempDirectory.path}/$id-temp.png');
    await tempPng.writeAsBytes(img.encodePng(padded));

    final compressed = await FlutterImageCompress.compressAndGetFile(
      tempPng.path,
      tempFilePath,
      format: CompressFormat.webp,
      quality: 90,
      minWidth: 512,
      minHeight: 512,
    );

    await tempPng.delete();

    if (compressed == null) {
      throw Exception('Failed to create webp');
    }
    return compressed;
  }

  Future<Uint8List> readImageBytes(String filePath) async {
    try {
      final file = File(filePath);
      return await file.readAsBytes();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeImgFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
