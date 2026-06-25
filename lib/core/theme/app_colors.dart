import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core neutrals
  static const Color black = Color(0xFF0A0E12);
  static const Color white = Color(0xFFF7F9FB);
  static const Color beige = Color(0xFFDFE7ED);
  static const Color beigeLight = Color(0xFFEBF1F5);

  // Brand reference
  static const Color brand = Color(0xFF8FD5F5);

  // Accent system (derived from brand)
  static const Color gold = Color(0xFF4BB8D8);
  static const Color goldLight = brand;
  static const Color goldDark = Color(0xFF2698B8);

  // Brand gradients
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [goldLight, gold, goldDark],
    stops: [0.0, 0.5, 1.0],
  );

  static const RadialGradient brandGradientRadial = RadialGradient(
    colors: [goldLight, gold, goldDark],
    stops: [0.0, 0.55, 1.0],
  );

  // Pastel accents (brand-tinted)
  static const Color pastelBlush = Color(0xFFE3F3FA);
  static const Color pastelSage = Color(0xFFDCEEF6);
  static const Color pastelSky = Color(0xFFD4EFF9);
  static const Color pastelLavender = Color(0xFFD8EEF5);
  static const Color pastelAmber = Color(0xFFDAF0F7);

  // Dark mode surfaces (cyan-tinted)
  static const Color darkSurface = Color(0xFF0C1117);
  static const Color darkCard = Color(0xFF151C24);
  static const Color darkCardElevated = Color(0xFF1D2631);
  static const Color darkDivider = Color(0xFF263040);

  // Semantic text
  static const Color textPrimary = Color(0xFF0D1820);
  static const Color textSecondary = Color(0xFF5A6B78);
  static const Color textTertiary = Color(0xFF8A9AAA);
  static const Color textOnDark = Color(0xFFE8EDF2);
  static const Color textMutedOnDark = Color(0xFF7D8D9D);

  // Crowd level semantic colors
  static const Color crowdLow = Color(0xFF3DAA8F);
  static const Color crowdMedium = Color(0xFFC49340);
  static const Color crowdHigh = Color(0xFFD06358);
}
