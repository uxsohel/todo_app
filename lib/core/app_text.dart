import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// All text styles come from the Figma file (Poppins, sizes 12/14/16).
class AppText {
  AppText._();

  static TextStyle _poppins(double size, FontWeight weight, Color color) =>
      GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: 1.5, // 12/18, 14/21, 16/24 like Figma
      );

  static TextStyle get title => _poppins(16, FontWeight.w600, Colors.black);
  static TextStyle get cardTitle => _poppins(16, FontWeight.w500, Colors.black);
  static TextStyle get category => _poppins(12, FontWeight.w500, AppColors.primary);
  static TextStyle get label => _poppins(14, FontWeight.w500, Colors.black);
  static TextStyle get input => _poppins(14, FontWeight.w400, Colors.black);
  static TextStyle get hint => _poppins(14, FontWeight.w500, AppColors.hint);
  static TextStyle get body14 => _poppins(14, FontWeight.w400, Colors.black);
  static TextStyle get small => _poppins(12, FontWeight.w400, Colors.black);
  static TextStyle get smallBold => _poppins(12, FontWeight.w600, Colors.black);
  static TextStyle get smallGrey => _poppins(12, FontWeight.w400, AppColors.textGrey);
  static TextStyle get smallGreyMedium => _poppins(12, FontWeight.w500, AppColors.textGrey);
  static TextStyle get chip => _poppins(12, FontWeight.w500, Colors.white);
  static TextStyle get badge => _poppins(12, FontWeight.w400, Colors.white);
  static TextStyle get button => _poppins(14, FontWeight.w500, Colors.white);
  static TextStyle get link => _poppins(12, FontWeight.w400, AppColors.primary);
  static TextStyle get link14 => _poppins(14, FontWeight.w500, AppColors.primary);
}
