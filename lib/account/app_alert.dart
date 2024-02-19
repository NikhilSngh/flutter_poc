import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/app_strings.dart';
import 'package:flutter_poc/helper/app_text_button.dart';
import 'package:flutter_poc/theme/ui_colors.dart';


class AppAlert {
  final String? title;
  final String? message;
  final String? confirmBtnText;
  final VoidCallback? cancelTap;
  final VoidCallback? confirmTap;
  final bool? isNeedConfirmBtn;
  const AppAlert(
      {this.title = '',
      this.message,
      this.confirmBtnText = AppStrings.ok,
      this.isNeedConfirmBtn = true,
      this.cancelTap,
      this.confirmTap});

  void showDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: UiColors.primaryTextColor.lightColor,
              title: title != '' ? Text(title ?? '',style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall) : null,
              content: Text(message ?? '',style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall),
              actions: [
                AppTextButton(
                    title: AppStrings.cancel,
                    textColor: UiColors.primaryTextColorWhite.lightColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (cancelTap != null) {
                        cancelTap!();
                      }
                    }),
                if (isNeedConfirmBtn ?? false)
                  AppTextButton(
                      title: confirmBtnText ?? '',
                      textColor: UiColors.primaryTextColorWhite.lightColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (confirmTap != null) {
                          confirmTap!();
                        }
                      })
              ]);
        });
  }
}
