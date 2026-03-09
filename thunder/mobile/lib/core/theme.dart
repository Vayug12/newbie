import "package:flutter/material.dart";

class AppTheme {
  static ThemeData get lightTheme {
    const seed = Color(0xFF0EA5A4);
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seed,
      scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      appBarTheme: const AppBarTheme(centerTitle: false),
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
