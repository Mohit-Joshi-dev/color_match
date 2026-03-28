import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized repository for all text styles used across the application.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _base => GoogleFonts.inter();

  // ── Global & Layout ──────────────────────────────────────────────

  /// Large hero styling for main screens (e.g. 'color')
  static TextStyle get heroTitle => _base.copyWith(
        fontSize: 60,
        fontWeight: FontWeight.w800,
        letterSpacing: -3,
        color: Colors.white,
      );

  /// Secondary screen titles (e.g. 'result')
  static TextStyle get sectionTitle => _base.copyWith(
        fontSize: 46,
        fontWeight: FontWeight.w800,
        letterSpacing: -2,
        color: Colors.white,
      );

  /// Standard descriptive text
  static TextStyle get subtitle => _base.copyWith(
        fontSize: 16,
        color: Colors.grey,
        height: 1.4,
      );

  /// General small uppercase labels
  static TextStyle get label => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: Colors.white,
      );

  /// Game logo 'Dialed.'
  static TextStyle get logoStyle => _base.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
      );

  /// Round indicator on game views e.g. '1/5'
  static TextStyle get roundIndicator => _base.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.white70,
      );

  // ── Start View ───────────────────────────────────────────────────

  /// Text style for the difficulty pill 'Easy'/'Hard'
  static TextStyle get difficultyToggle => _base.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 14,
      );

  // ── Memorize View ────────────────────────────────────────────────

  /// Huge numerical timer countdown e.g. '361'
  static TextStyle get timerDisplay => _base.copyWith(
        fontSize: 76,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        height: 1.0,
        letterSpacing: -2,
      );

  /// Label sitting under the timer 'Seconds to remember'
  static TextStyle get timerLabel => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.7),
      );

  // ── Round Result View ─────────────────────────────────────────────

  /// Used for small subtle labels above data fields
  static TextStyle get resultOverLabel => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.6),
      );

  /// Raw H/S/V string format
  static TextStyle get hsvLabel => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: 0.5,
      );

  /// Single round huge score
  static TextStyle get resultScoreDisplay => _base.copyWith(
        fontSize: 68,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        height: 1.0,
        letterSpacing: -2,
      );

  /// Witty feedback text below a round score
  static TextStyle get resultMessage => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.8),
        height: 1.3,
      );

  // ── End View ──────────────────────────────────────────────────────

  /// Giant float showing the final average score
  static TextStyle get finalScoreValue => _base.copyWith(
        fontSize: 90,
        fontWeight: FontWeight.w800,
        height: 1.0,
        color: Colors.white,
      );
}
