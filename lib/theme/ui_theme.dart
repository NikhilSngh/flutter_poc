import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poc/theme/sizes.dart';
import 'package:flutter_poc/theme/ui_colors.dart';
import 'package:flutter_poc/theme/ui_text_styles.dart';

class UiTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Inter',
    appBarTheme: _appBarThemeData(Brightness.light),
    textTheme: UiTextStyles.defaultWhiteTextTheme,
    cardTheme: _cardTheme(),
  );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      appBarTheme: _appBarThemeData(Brightness.dark),
      textTheme: UiTextStyles.defaultDarkTextTheme,
      cardTheme: _cardTheme());

  static AppBarTheme _appBarThemeData(Brightness brightness) {
    return AppBarTheme(
        backgroundColor: UiColors.appBarColor[brightness],
        iconTheme: IconThemeData(color: UiColors.primaryColor[brightness]),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: brightness,
            statusBarIconBrightness: brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
            statusBarColor: Colors.transparent));
  }

  static CardTheme _cardTheme() {
    return CardTheme(
        color: UiColors.cardColor.lightColor, elevation: Sizes.size10);
  }
}
