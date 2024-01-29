import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_poc/helper/app_text_button.dart';
import 'package:image_picker/image_picker.dart';


class AppImagePicker {
  final BuildContext context;
  final ValueChanged<File>? pickerImage;

  AppImagePicker(this.context,{this.pickerImage});

  void show() {
    _imagePicker();
  }

  void _imagePicker() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("chooseImage"),
        actions: [
      AppElevatedButton(
            title: "camera",
            onPressed: () => {Navigator.pop(context, ImageSource.camera)},
          ),
          AppElevatedButton(
            title:"gallery",
            onPressed: () => {Navigator.pop(context, ImageSource.gallery)},
          )
        ])
    ).then((ImageSource? source) async {
      if (source == null) return;
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;
      if (pickerImage != null) {
        pickerImage!(File(pickedFile.path));
      }
    });
  }
}
