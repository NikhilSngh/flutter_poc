 import 'package:flutter/material.dart';
import 'package:flutter_poc/theme/ui_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class UiTextStyles{

   static TextTheme defaultWhiteTextTheme = TextTheme(titleSmall: _getTitleSmall(),
   );

   static TextTheme defaultDarkTextTheme = TextTheme(titleSmall: _getTitleSmallDark(),
   );

   static TextTheme elevateButtonTextTheme = TextTheme(titleSmall: _getTitleSmall(),
   );

   static TextStyle _getTitleSmall() => GoogleFonts.inter(
     fontSize: 16,
     fontWeight: FontWeight.w900,
     letterSpacing: 0.14,
     color: Colors.white
   );

   static TextStyle _getTitleSmallDark() => GoogleFonts.inter(
       fontSize: 16,
       fontWeight: FontWeight.w900,
       letterSpacing: 0.14,
       color:UiColors.informGreyColor.darkColor
   );

 }