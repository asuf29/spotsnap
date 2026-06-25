import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_constants.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(isDark: false);
  static ThemeData get dark => _build(isDark: true);

  static ThemeData _build({required bool isDark}) {
    final colorScheme = isDark
        ? const ColorScheme.dark(
            primary: AppColors.gold,
            onPrimary: AppColors.black,
            secondary: AppColors.goldDark,
            surface: AppColors.darkSurface,
            onSurface: AppColors.textOnDark,
            error: Color(0xFFE57373),
          )
        : const ColorScheme.light(
            primary: AppColors.gold,
            onPrimary: AppColors.white,
            secondary: AppColors.goldDark,
            surface: AppColors.white,
            onSurface: AppColors.textPrimary,
            error: Color(0xFFE57373),
          );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          isDark ? AppColors.darkSurface : AppColors.white,
      textTheme: AppTypography.textTheme(isDark: isDark),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor:
            isDark ? AppColors.textOnDark : AppColors.textPrimary,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? AppColors.darkCard : AppColors.white,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.darkDivider : AppColors.beige,
        thickness: 1,
      ),
      // Material 3 NavigationBar theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor:
            isDark ? AppColors.darkCard : AppColors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        height: 64,
        indicatorColor:
            AppColors.gold.withValues(alpha: isDark ? 0.22 : 0.14),
        indicatorShape: const StadiumBorder(),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.gold, size: 22);
          }
          return IconThemeData(
            color: isDark
                ? AppColors.textMutedOnDark
                : AppColors.textSecondary,
            size: 22,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.gold,
              letterSpacing: 0.1,
            );
          }
          return TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: isDark
                ? AppColors.textMutedOnDark
                : AppColors.textSecondary,
          );
        }),
      ),
      // Keep for any remaining BottomNavigationBar usage
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            isDark ? AppColors.darkCard : AppColors.white,
        selectedItemColor: AppColors.gold,
        unselectedItemColor:
            isDark ? AppColors.textMutedOnDark : AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? AppColors.darkCard
            : AppColors.beigeLight.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: TextStyle(
          color: isDark ? AppColors.textMutedOnDark : AppColors.textSecondary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            letterSpacing: 0.2,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? AppColors.darkCard : AppColors.beigeLight,
        labelStyle: TextStyle(
          color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        side: BorderSide(
          color: isDark ? AppColors.darkDivider : AppColors.beige,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
