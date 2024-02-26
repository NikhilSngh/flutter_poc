 import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/app_font_constant.dart';
import 'package:flutter_poc/theme/ui_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class UiTextStyles{

   static TextTheme defaultWhiteTextTheme = TextTheme(titleSmall: getTitleSmall(),
   );

   static TextTheme defaultDarkTextTheme = TextTheme(titleSmall: _getTitleSmallDark(),
   );

   static TextStyle getTitleSmall() => GoogleFonts.inter(
       fontSize: AppFontConstant.extraSmall,
       fontWeight: FontWeight.w500,
       letterSpacing: 0.14,
       color: Colors.white
   );

   static TextStyle getTitleExtraSmall() => GoogleFonts.inter(
       fontSize: AppFontConstant.extraSmall,
       fontWeight: FontWeight.w500,
       letterSpacing: 0.14,
       color: Colors.white
   );


   static TextStyle _getTitleSmallDark() => GoogleFonts.inter(
       fontSize: AppFontConstant.extraSmall,
       fontWeight: FontWeight.w600,
       letterSpacing: 0.14,
       color:UiColors.informGreyColor.darkColor
   );

 }