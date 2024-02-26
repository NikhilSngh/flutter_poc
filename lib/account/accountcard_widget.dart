import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/app_padding_margin_constants.dart';
import 'package:flutter_poc/constant/radius_constants.dart';
import 'package:flutter_poc/theme/ui_colors.dart';


class ProfileCardWidget extends StatelessWidget {
  final Widget child;
  const ProfileCardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppPaddingMarginConstant.small),
        child: Container(
            padding: const EdgeInsets.all(AppPaddingMarginConstant.large),
            decoration: BoxDecoration(
                color: UiColors.primaryTextColor.lightColor,
                borderRadius: BorderRadius.circular(AppRadius.small)),
            child: child));
  }
}
