 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiTextStyles{

   static TextTheme defaultTextTheme = TextTheme(titleSmall: _getSubtitle());

   static TextStyle _getSubtitle() => GoogleFonts.inter(
     fontSize: 14,
     fontWeight: FontWeight.w600,
     letterSpacing: 0.14,
   );
 }