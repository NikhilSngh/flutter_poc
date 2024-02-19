import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<File> saveFile(File file) async {
    String path = await _getPath();
    final String fileName = basename(file.path);
    final File localImage = await file.copy('$path/$fileName');
    return localImage;
  }

  Future<File?> getFile(String fileName) async {
    if (fileName.isEmpty) {
      return null;
    }
    String path = await _getPath();
    File file = File('$path/$fileName');
    if (file.existsSync()) {
    return file;
    } else {
      return null;
    }
  }

  Future<String> _getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}