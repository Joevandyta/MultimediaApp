import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FileServices { 
  Future<String> saveImgBytes(Uint8List bytes, String fileCode, {extension = 'png'}) async {
    final appDir = await getApplicationDocumentsDirectory();  
    final stickersDirectory = Directory('${appDir.path}/$fileCode');
    await stickersDirectory.create(recursive: true);
    final String savedStickerId = const Uuid().v4();
    final String filePath = '${stickersDirectory.path}/$savedStickerId.$extension';

    await File(filePath).writeAsBytes(bytes);

    return filePath;
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
