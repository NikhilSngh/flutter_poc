import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/gen/assets.gen.dart';
import 'package:flutter_poc/signup/image_picker.dart';

import 'dart:io';

import 'package:flutter_poc/theme/sizes.dart';
import 'package:flutter_poc/theme/ui_colors.dart';


class ProfileImage extends StatefulWidget {
  final ValueChanged<File>? pickerImage;
  final String? gender;
  File? pickedImage;

  ProfileImage({this.pickerImage,
    this.pickedImage,
    this.gender, super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
          padding: const EdgeInsets.all(Sizes.size8),
          child: Container(
              width: Sizes.size100,
              height: Sizes.size100,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                border: Border.all(
                    color: UiColors.primaryTextColor.lightColor!,
                    width: 2.0),
                borderRadius: BorderRadius.circular(Sizes.size50),
              ),
              child: widget.pickedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(Sizes.size50),
                      child: Image.file(widget.pickedImage!,
                          fit: BoxFit.cover,
                          height: Sizes.size100,
                          width: Sizes.size100))
                  : widget.gender == AppStrings.other
                      ? Assets.images.other.image()
                      : widget.gender == AppStrings.female
                          ? Assets.images.woman.image()
                          : Assets.images.man.image())),
      Positioned(
          right: 0,
          top: 60,
          child: InkWell(
              onTap: () {
                AppImagePicker(context, pickerImage: (image) {
                  setState(() {
                    widget.pickedImage = image;
                  });
                  if (widget.pickerImage != null &&
                      widget.pickedImage != null) {
                    widget.pickerImage!(widget.pickedImage!);
                  }
                }).show();
              },
              child: Container(
                  padding: const EdgeInsets.all(Sizes.size4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: UiColors.primaryTextColor.lightColor ??
                          const Color(0xFFD9177F),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(Sizes.size15),
                  ),
                  child: Icon(Icons.edit,
                      color: UiColors.primaryTextColor.lightColor ??
                          const Color(0xFFD9177F),
                      size: Sizes.size20))))
    ]);
  }
}
