import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poc/constant/font_size_constants.dart';
import 'package:flutter_poc/constant/spacing_constants.dart';
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
    elevatedButtonTheme: _buttonTheme(),
    bottomNavigationBarTheme: _bottomNavigationBarLightTheme(),
    scaffoldBackgroundColor: UiColors.onPrimary.lightColor,
    inputDecorationTheme: _inputDecorationTheme(),
  );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      appBarTheme: _appBarThemeData(Brightness.dark),
      textTheme: UiTextStyles.defaultDarkTextTheme,
      cardTheme: _cardTheme(),
      elevatedButtonTheme: _buttonTheme(),
      bottomNavigationBarTheme: _bottomNavigationBarDarkTheme(),
      scaffoldBackgroundColor: UiColors.onPrimary.darkColor,
      inputDecorationTheme: _inputDecorationTheme());

  static AppBarTheme _appBarThemeData(Brightness brightness) {
    return AppBarTheme(
      backgroundColor: UiColors.appBarColor[brightness],
      iconTheme: IconThemeData(color: UiColors.onPrimary[brightness]),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: brightness,
          statusBarIconBrightness: brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
          statusBarColor: Colors.transparent),
      titleTextStyle: TextStyle(color: UiColors.onPrimary[brightness]),
    );
  }

  static ElevatedButtonThemeData _buttonTheme() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: UiColors.appThemeColor.lightColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: SpacingConstant.buttonPaddingElevatedButtonSmall,
                vertical: SpacingConstant.buttonPaddingElevatedButtonSmall),
            textStyle: const TextStyle(
              fontSize: AppFontSize.regular,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            )));
  }

  static BottomNavigationBarThemeData _bottomNavigationBarDarkTheme() {
    return BottomNavigationBarThemeData(
        selectedItemColor: UiColors.onPrimary.darkColor,
        backgroundColor: UiColors.bottomBarColor.lightColor,
        unselectedItemColor: UiColors.greyColor.lightColor);
  }

  static BottomNavigationBarThemeData _bottomNavigationBarLightTheme() {
    return BottomNavigationBarThemeData(
        selectedItemColor: UiColors.onPrimary.lightColor,
        backgroundColor: UiColors.bottomBarColor.lightColor,
        unselectedItemColor: UiColors.greyColor.lightColor);
  }

  static CardTheme _cardTheme() {
    return CardTheme(
        color: UiColors.cardColor.lightColor, elevation: Sizes.size10);
  }

  static _inputDecorationTheme() {
    return InputDecorationTheme(
      errorStyle: TextStyle(color: UiColors.errorColor.darkColor),
    );
  }
}
