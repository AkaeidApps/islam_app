import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  /// Arabic text style using Amiri font
  static TextStyle arabicStyle({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return GoogleFonts.amiri(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      textBaseline: TextBaseline.alphabetic,
      height: 2.0,
    );
  }

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    textTheme: _textTheme(Brightness.light),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textOnPrimary,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.textSecondary,
      backgroundColor: AppColors.surface,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 12),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.primary.withOpacity(0.15),
      thickness: 1,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.surfaceDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      onPrimary: AppColors.textOnPrimary,
      secondary: AppColors.accent,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
    ),
    textTheme: _textTheme(Brightness.dark),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.primaryLight,
      elevation: 0,
      centerTitle: true,
    ),
  );

  static TextTheme _textTheme(Brightness b) {
    final c = b == Brightness.light ? AppColors.textPrimary : Colors.white;
    final s = b == Brightness.light ? AppColors.textSecondary : Colors.grey[400];

    return GoogleFonts.hindSiliguriTextTheme().copyWith(
      headlineLarge: GoogleFonts.hindSiliguri(fontSize: 28, fontWeight: FontWeight.w700, color: c),
      titleLarge: GoogleFonts.hindSiliguri(fontSize: 22, fontWeight: FontWeight.w700, color: c),
      titleMedium: GoogleFonts.hindSiliguri(fontSize: 18, fontWeight: FontWeight.w600, color: c),
      bodyLarge: GoogleFonts.hindSiliguri(fontSize: 16, color: c),
      bodyMedium: GoogleFonts.hindSiliguri(fontSize: 14, color: s),
      labelLarge: GoogleFonts.hindSiliguri(fontSize: 14, fontWeight: FontWeight.w600, color: c),
    );
  }
}