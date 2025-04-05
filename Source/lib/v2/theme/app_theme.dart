import 'package:flutter/material.dart';

// Colors based on CSS variables
class AppColors {
  static const Color primary = Color(0xFF0A1128);
  static const Color primaryLight = Color(0xFF1A2138);
  static const Color secondary = Color(0xFFFFD700); // --color-secondary: #ffd700;
  static const Color accent1 = Color(0xFF00B4D8); // --color-accent-1: #00b4d8;
  static const Color accent2 = Color(0xFF7209B7); // --color-accent-2: #7209b7;
  static const Color text = Color(0xFFF8F9FA); // --color-text: #f8f9fa;
  static const Color textMuted = Color(0xFFADB5BD); // --color-text-muted: #adb5bd;
  static const Color background = Color(0xFF0A1128); // --color-background: #0a1128;
  static const Color card = Color.fromRGBO(26, 33, 56, 0.8); // --color-card: rgba(26, 33, 56, 0.8);
  static const Color overlay = Color.fromRGBO(
    10,
    17,
    40,
    0.9,
  ); // --color-overlay: rgba(10, 17, 40, 0.9);
}

// Font Families based on CSS variables
class AppFonts {
  static const String heading = 'Poppins';
  static const String body = 'Inter';
  static const String code = 'Fira Code';
}

// Theme constants based on CSS variables
class AppTheme {
  // Spacing (use double for compatibility with ScreenUtil)
  static const double spacingXs = 8.0; // 0.5rem approx
  static const double spacingSm = 16.0; // 1rem approx
  static const double spacingMd = 32.0; // 2rem approx
  static const double spacingLg = 48.0; // 3rem approx
  static const double spacingXl = 80.0; // 5rem approx

  // Border Radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 16.0;
  static const double borderRadiusXl = 24.0;
  // Note: borderRadiusCircle is 50%, handled directly in BoxDecoration

  // Shadows (approximated)
  static const BoxShadow shadowSm = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 4,
    offset: Offset(0, 2),
  );
  static const BoxShadow shadowMd = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.2),
    blurRadius: 8,
    offset: Offset(0, 4),
  );
  static const BoxShadow shadowLg = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    blurRadius: 16,
    offset: Offset(0, 8),
  );
  static const BoxShadow shadowXl = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.4),
    blurRadius: 24,
    offset: Offset(0, 12),
  );

  // Transitions (Durations) - Can be defined here if needed frequently
  static const Duration transitionFast = Duration(milliseconds: 200);
  static const Duration transitionNormal = Duration(milliseconds: 300);
  static const Duration transitionSlow = Duration(milliseconds: 500);
}

// Basic ThemeData using the defined constants
ThemeData buildAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.primaryLight,
      onPrimary: AppColors.text,
      onSecondary: AppColors.primary,
      onSurface: AppColors.text,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: AppFonts.heading, color: AppColors.text),
      displayMedium: TextStyle(fontFamily: AppFonts.heading, color: AppColors.text),
      displaySmall: TextStyle(fontFamily: AppFonts.heading, color: AppColors.text),
      headlineMedium: TextStyle(fontFamily: AppFonts.heading, color: AppColors.text),
      headlineSmall: TextStyle(fontFamily: AppFonts.heading, color: AppColors.text),
      titleLarge: TextStyle(fontFamily: AppFonts.heading, color: AppColors.text),
      bodyLarge: TextStyle(fontFamily: AppFonts.body, color: AppColors.text),
      bodyMedium: TextStyle(fontFamily: AppFonts.body, color: AppColors.textMuted),
      labelLarge: TextStyle(fontFamily: AppFonts.heading, color: AppColors.primary), // For buttons
    ).apply(bodyColor: AppColors.text, displayColor: AppColors.text),
    fontFamily: AppFonts.body, // Default font family
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.overlay,
      foregroundColor: AppColors.text,
      elevation: 0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.secondary,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd), // Use constant
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingSm,
        ), // Use constants
        textStyle: const TextStyle(fontFamily: AppFonts.heading, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd), // Use constant
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.text,
        side: const BorderSide(color: AppColors.secondary, width: 2),
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingSm,
        ), // Use constants
        textStyle: const TextStyle(fontFamily: AppFonts.heading, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd), // Use constant
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.primary,
      labelStyle: TextStyle(color: AppColors.textMuted),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary),
        borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadiusSm)), // Use constant
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryLight),
        borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadiusSm)), // Use constant
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadiusSm)), // Use constant
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.card,
      elevation: 4, // Approximating --shadow-md (Consider using AppTheme.shadowMd.blurRadius / 2 ?)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd), // Use constant
      ),
    ),
    dividerColor: AppColors.primaryLight,
  );
}
