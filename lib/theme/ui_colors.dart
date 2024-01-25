
import 'package:flutter/material.dart';

class UiColors{

  UiColors._();

  static const Color _pureWhite = Color(0xFFFFFFFF);
  static const Color _pureDark = Color(0xFF000000);
  static const Color _informGrey = Color(0xFF191919);
  static const Color _blue = Color(0xFF394094);


  static final Map<Brightness, Color> canvasColor =
  _buildColor(lightColor: _pureWhite, darkColor: _pureWhite);

  static final Map<Brightness, Color> primaryTextColor =
  _buildColor(lightColor: _blue, darkColor: _blue);

  static final Map<Brightness, Color> primaryTextColorWhite =
  _buildColor(lightColor: _pureWhite, darkColor: _pureWhite);

  static final Map<Brightness, Color> onPrimary =
  _buildColor(lightColor: _pureWhite, darkColor: _pureDark);

  static final Map<Brightness, Color> informGreyColor =
  _buildColor(lightColor: _informGrey, darkColor: _informGrey);

  static final Map<Brightness, Color> cardColor =
  _buildColor(lightColor: _blue, darkColor: _blue);

  static final Map<Brightness, Color> appBarColor =
  _buildColor(lightColor: _blue, darkColor: _blue);

  static final Map<Brightness, Color> appThemeColor =
  _buildColor(lightColor: _blue, darkColor: _blue);




  static Map<Brightness, Color> _buildColor(
      {required Color lightColor, required Color darkColor}) {
    final Map<Brightness, Color> colorMap = {};

    colorMap.putIfAbsent(Brightness.light, () => lightColor);
    colorMap.putIfAbsent(Brightness.dark, () => darkColor);

    return colorMap;
  }


}

extension ColorMap on Map<Brightness, Color> {
  Color? get lightColor => this[Brightness.light];

  Color? get darkColor => this[Brightness.dark];

  Color? platformBrightnessColor(BuildContext context) {
    // We need to check the theme mode to be able disable dark mode completely.
    // Indeed, Platform.brightness will still be `dark` even if we force the ThemeMode to be `light` in the MaterialApp.
    final ThemeMode themeMode =
        context.findAncestorWidgetOfExactType<MaterialApp>()?.themeMode ??
            ThemeMode.system;
    final Brightness brightness;

    switch (themeMode) {
      case ThemeMode.system:
        brightness = MediaQuery.of(context).platformBrightness;
        break;
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
    }

    return this[brightness];
  }
}