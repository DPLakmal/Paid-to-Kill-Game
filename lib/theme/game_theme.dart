import 'package:flutter/material.dart';

/// Retro stealth tactical styling reflecting mid-2000s J2ME spy-thriller aesthetic.
class GameTheme {
  static const Color background = Color(0xFF090D14);
  static const Color surface = Color(0xFF131B26);
  static const Color surfaceLight = Color(0xFF1C2736);
  static const Color border = Color(0xFF2A3B4F);

  // Tactical HUD indicators
  static const Color terminalGreen = Color(0xFF00FF9D);
  static const Color alertRed = Color(0xFFFF3344);
  static const Color suspiciousAmber = Color(0xFFFFB800);
  static const Color quietBlue = Color(0xFF3898EC);
  static const Color textMuted = Color(0xFF8B9BB4);
  static const Color textBright = Color(0xFFF0F6FC);

  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: terminalGreen,
      colorScheme: const ColorScheme.dark(
        primary: terminalGreen,
        secondary: quietBlue,
        surface: surface,
        error: alertRed,
      ),
      fontFamily: 'monospace',
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: terminalGreen,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontFamily: 'monospace',
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: border, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: terminalGreen,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 14,
            fontFamily: 'monospace',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: terminalGreen,
          side: const BorderSide(color: terminalGreen, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 13,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}
