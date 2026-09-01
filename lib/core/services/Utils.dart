import 'package:pro_image_editor/core/platform/io/io_helper.dart';

extension FileExtension on File {
  String get extension => path.split('.').last.toLowerCase();

  bool get isValidImage {
    const validExtensions = ['jpg', 'jpeg', 'png', 'webp', 'gif'];
    return validExtensions.contains(extension);
  }
}
