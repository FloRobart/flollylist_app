import 'package:flutter/material.dart';

enum AppFontSize { small, medium, large, xlarge, xxlarge }

class AppTheme {
  AppTheme._();

  /// Couleur principale de FlollyList : le rouge de Noël du logo.
  static const Color primarySeed = Color(0xFF721414);

  /// Couleurs custom (faciles à changer)
  static const Color successColor = Color(0xFF2E7D32);
  static const Color errorColor = Color(0xFFE53935);
  static const Color warningColor = Color(0xFFFF9800);

  static const fontSizes = {
    AppFontSize.small: 12.0,
    AppFontSize.medium: 16.0,
    AppFontSize.large: 20.0,
    AppFontSize.xlarge: 24.0,
    AppFontSize.xxlarge: 28.0,
  };

  /// LIGHT THEME
  static ThemeData light() => _buildTheme(Brightness.light);

  /// DARK THEME
  static ThemeData dark() => _buildTheme(Brightness.dark);

  /// Construit le thème d'une luminosité : clair et sombre ne diffèrent que par leurs couleurs.
  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primarySeed,
      brightness: brightness,
      /* Keeps the primary color close to the red of the logo, instead of a paler tone */
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );
    final roundedShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: roundedShape,
          elevation: 1,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: roundedShape,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}
