import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/app_padding_margin_constants.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/helper/app_text_button.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  final BuildContext context;
  final ValueChanged<Uint8List>? pickerImage;
  Uint8List? _imageBytes;

  AppImagePicker(this.context, {this.pickerImage});

  void show() {
    _imagePicker();
  }

  void _imagePicker() {
    showDialog<ImageSource>(
        context: context,
        builder: (context) =>
            AlertDialog(content: const Text(AppStrings.chooseImage), actions: [
              !kIsWeb?AppElevatedButton(
                title: AppStrings.camera,
                onPressed: () => {Navigator.pop(context, ImageSource.camera)},
              ):const SizedBox.shrink(),
              Container(
                margin: const EdgeInsets.only(top: AppPaddingMarginConstant.extraSmall),
                child: AppElevatedButton(
                  title: AppStrings.gallery,
                  onPressed: () => {
                    if (kIsWeb) {_pickImageWeb()} else {_pickImage()}
                  },
                ),
              )
            ]));
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      _imageBytes = Uint8List.fromList(imageBytes);
      pickerImage!(_imageBytes!);
    }
    Navigator.of(context).pop();
  }

  Future<void> _pickImageWeb() async {
    final file = await file_picker.FilePicker.platform
        .pickFiles(type: file_picker.FileType.image);
    if (file != null) {
      final bytes = file.files.first.bytes;
      _imageBytes = Uint8List.fromList(bytes!);
      pickerImage!(_imageBytes!);
    }
    Navigator.of(context).pop();
  }
}
