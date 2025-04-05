import 'package:flutter/material.dart';

// Colors based on CSS variables
class V2Colors {
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
class V2Fonts {
  static const String heading = 'Poppins';
  static const String body = 'Inter';
  static const String code = 'Fira Code';
}

// Theme constants based on CSS variables
class V2Theme {
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
ThemeData buildV2Theme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: V2Colors.primary,
    scaffoldBackgroundColor: V2Colors.background,
    colorScheme: const ColorScheme.dark(
      primary: V2Colors.primary,
      secondary: V2Colors.secondary,
      surface: V2Colors.primaryLight,
      onPrimary: V2Colors.text,
      onSecondary: V2Colors.primary,
      onSurface: V2Colors.text,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: V2Fonts.heading, color: V2Colors.text),
      displayMedium: TextStyle(fontFamily: V2Fonts.heading, color: V2Colors.text),
      displaySmall: TextStyle(fontFamily: V2Fonts.heading, color: V2Colors.text),
      headlineMedium: TextStyle(fontFamily: V2Fonts.heading, color: V2Colors.text),
      headlineSmall: TextStyle(fontFamily: V2Fonts.heading, color: V2Colors.text),
      titleLarge: TextStyle(fontFamily: V2Fonts.heading, color: V2Colors.text),
      bodyLarge: TextStyle(fontFamily: V2Fonts.body, color: V2Colors.text),
      bodyMedium: TextStyle(fontFamily: V2Fonts.body, color: V2Colors.textMuted),
      labelLarge: TextStyle(fontFamily: V2Fonts.heading, color: V2Colors.primary), // For buttons
    ).apply(bodyColor: V2Colors.text, displayColor: V2Colors.text),
    fontFamily: V2Fonts.body, // Default font family
    appBarTheme: const AppBarTheme(
      backgroundColor: V2Colors.overlay,
      foregroundColor: V2Colors.text,
      elevation: 0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: V2Colors.secondary,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd), // Use constant
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: V2Colors.secondary,
        foregroundColor: V2Colors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: V2Theme.spacingMd,
          vertical: V2Theme.spacingSm,
        ), // Use constants
        textStyle: const TextStyle(fontFamily: V2Fonts.heading, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd), // Use constant
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: V2Colors.text,
        side: const BorderSide(color: V2Colors.secondary, width: 2),
        padding: EdgeInsets.symmetric(
          horizontal: V2Theme.spacingMd,
          vertical: V2Theme.spacingSm,
        ), // Use constants
        textStyle: const TextStyle(fontFamily: V2Fonts.heading, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd), // Use constant
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: V2Colors.primary,
      labelStyle: TextStyle(color: V2Colors.textMuted),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: V2Colors.secondary),
        borderRadius: BorderRadius.all(Radius.circular(V2Theme.borderRadiusSm)), // Use constant
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: V2Colors.primaryLight),
        borderRadius: BorderRadius.all(Radius.circular(V2Theme.borderRadiusSm)), // Use constant
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(V2Theme.borderRadiusSm)), // Use constant
      ),
    ),
    cardTheme: CardTheme(
      color: V2Colors.card,
      elevation: 4, // Approximating --shadow-md (Consider using AppTheme.shadowMd.blurRadius / 2 ?)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd), // Use constant
      ),
    ),
    dividerColor: V2Colors.primaryLight,
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(V2Colors.secondary), // İstediğiniz rengi buraya girin
    ),
  );
}
