import 'package:flutter/material.dart';

import 'app_text_styles.dart';

/// Centralized theme definitions for the Color Game.
class AppTheme {
  AppTheme._();

  // ── Brand Colors ────────────────────────────────────────────────────────
  static const Color glowBlue = Color(0xFF3B82F6);
  static const Color lightBg = Color(0xFFF3F4F6);
  static const Color darkBg = Color(0xFF050505);
  static const Color lightCardBg = Colors.black;
  static const Color darkCardBg = Color(0xFF111111);

  // ── Theme Data ──────────────────────────────────────────────────────────

  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBg,
        primaryColor: Colors.black,
        cardColor: lightCardBg,
        textTheme: TextTheme(
          bodyMedium: AppTextStyles.subtitle.copyWith(color: Colors.white),
          headlineLarge: AppTextStyles.heroTitle,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            textStyle: AppTextStyles.subtitle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBg,
        primaryColor: Colors.white,
        cardColor: darkCardBg,
        textTheme: TextTheme(
          bodyMedium: AppTextStyles.subtitle.copyWith(color: Colors.white),
          headlineLarge: AppTextStyles.heroTitle,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            textStyle: AppTextStyles.subtitle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      );

  // ── Glow ─────────────────────────────────────────────────────────────────

  static Color glowColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? glowBlue.withOpacity(0.15)
        : glowBlue.withOpacity(0.4);
  }
}
