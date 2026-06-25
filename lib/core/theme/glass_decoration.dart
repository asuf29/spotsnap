import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';

class GlassDecoration {
  GlassDecoration._();

  static BoxDecoration box({
    required bool isDark,
    double borderRadius = 24,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.white.withValues(alpha: 0.7),
        width: 0.8,
      ),
      color: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.white.withValues(alpha: 0.65),
    );
  }

  static Widget backdrop({
    required Widget child,
    required bool isDark,
    double sigma = 18,
    double borderRadius = 24,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: DecoratedBox(
          decoration: box(isDark: isDark, borderRadius: borderRadius),
          child: child,
        ),
      ),
    );
  }

  static LinearGradient accentShimmer() {
    return const LinearGradient(
      colors: [AppColors.gold, AppColors.goldDark, AppColors.gold],
      stops: [0.0, 0.5, 1.0],
    );
  }
}
