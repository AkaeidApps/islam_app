import 'package:flutter/material.dart';

abstract final class AppColors {
  // PRIMARY (আপনার রঙ)
  static const primary = Color(0xFF0BE881);
  static const primaryDark = Color(0xFF08B865);
  static const primaryLight = Color(0xFF5DF0AE);

  // Accent (সোনালি)
  static const accent = Color(0xFFD4AF37);
  static const accentLight = Color(0xFFF0D878);

  // Background
  static const background = Color(0xFFF0FBF5);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF0D1117);

  // Text
  static const textPrimary = Color(0xFF0D1B12);
  static const textSecondary = Color(0xFF5A6B60);
  static const textOnPrimary = Color(0xFF00391F);

  // Status
  static const error = Color(0xFFD32F2F);
  static const success = primary;
  static const warning = Color(0xFFFFA000);

  // Missing getters referenced by UI widgets
  static const primaryContainer = Color(0xFFD1FADF);
  static const textHint = Color(0xFF9CA3AF);
  static const darkTextPrimary = Color(0xFFF1F0FF);
  static const darkTextSecondary = Color(0xFFA5A0C0);
  static const darkSurfaceVariant = Color(0xFF2D2A4A);
}