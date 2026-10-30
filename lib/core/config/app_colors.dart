import 'package:flutter/material.dart';

/// Dark, stadium-at-night palette.
abstract final class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0F172A);
  static const Color surface = Color(0xFF1E293B);
  static const Color surfaceLight = Color(0xFF273449);
  static const Color border = Color(0xFF334155);

  // Brand
  static const Color primary = Color(0xFF22C55E); // pitch green
  static const Color primaryDark = Color(0xFF15803D);
  static const Color secondary = Color(0xFFFACC15); // trophy gold
  static const Color accent = Color(0xFF38BDF8); // floodlight blue

  // Text
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textHint = Color(0xFF64748B);
  static const Color onPrimary = Color(0xFF052E16);

  // Status
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF13233A), background],
  );
}
