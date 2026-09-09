import 'package:flutter/material.dart';
import 'package:smart_task_manger/core/theme/app_colors.dart';
import 'package:smart_task_manger/core/theme/app_radius.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';
import 'package:smart_task_manger/core/theme/app_typography.dart';

/// Defines the application's overall theme, including color 
/// schemes, typography and other visual properties.
abstract final class AppTheme {
  /// Returns the light theme configuration for the application.
  static ThemeData get lightTheme {
    return ThemeData(
      // Tells Flutter to use Material 3 components and styling.
      useMaterial3: true,
      
      // ThemeData represents a light theme.
      brightness: Brightness.light,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),

      scaffoldBackgroundColor: AppColors.lightBackground,

      appBarTheme: _appBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
      ),

      inputDecorationTheme: _inputDecorationTheme(
        fillColor: AppColors.lightSurface,
        borderColor: AppColors.lightBorder,
      ),

      filledButtonTheme: _filledButtonTheme(),

      textTheme: AppTypography.textTheme.apply(
        // Sets the color used by body-style text
        bodyColor: AppColors.lightTextPrimary,
        // Sets the color used by display/headline-style text
        displayColor: AppColors.lightTextPrimary,
      ),

    );
  }
  
  /// Returns the dark theme configuration for the application.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),

      scaffoldBackgroundColor: AppColors.darkBackground,

      appBarTheme: _appBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
      ),

      inputDecorationTheme: _inputDecorationTheme(
        fillColor: AppColors.darkSurface,
        borderColor: AppColors.darkBorder,
      ),

      filledButtonTheme: _filledButtonTheme(),

      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.darkTextPrimary,
        displayColor: AppColors.darkTextPrimary,
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      border: _border(color: borderColor),
      enabledBorder: _border(color: borderColor),
      focusedBorder: _border(
        color: AppColors.primary,
        width: 1.5,
      ),
      errorBorder: _border(color: AppColors.error),
      focusedErrorBorder: _border(
        color: AppColors.error,
        width: 1.5,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
    );
  }

  static OutlineInputBorder _border({
    required Color color,
    double width = 1.0,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  static AppBarThemeData _appBarTheme({
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return AppBarThemeData(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      centerTitle: false,
    );
  }

  static FilledButtonThemeData _filledButtonTheme() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        textStyle: AppTypography.textTheme.labelLarge,
        elevation: 0,
      ),
    );
  }
}

