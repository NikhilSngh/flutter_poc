
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poc/theme/ui_colors.dart';
import 'package:flutter_poc/theme/ui_text_styles.dart';

class UiTheme{

  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Inter',
    appBarTheme: _appBarThemeData(Brightness.light),
    textTheme: UiTextStyles.defaultTextTheme.apply(
        bodyColor: UiColors.onPrimary.lightColor,
        displayColor: UiColors.onPrimary.lightColor),
  );


  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      appBarTheme: _appBarThemeData(Brightness.dark),
    textTheme: UiTextStyles.defaultTextTheme.apply(
        bodyColor: UiColors.informGreyColor.darkColor,
        displayColor: UiColors.informGreyColor.darkColor),);




  static AppBarTheme _appBarThemeData(Brightness brightness) {
    return AppBarTheme(
        backgroundColor: UiColors.canvasColor[brightness],
        iconTheme: IconThemeData(color: UiColors.primaryColor[brightness]),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: brightness,
            statusBarIconBrightness: brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
            statusBarColor: Colors.transparent));
  }
}

