import "package:flutter/material.dart";

class AppTheme {
  static const primaryColor = Color(0xFF6366F1);
  static const secondaryColor = Color(0xFF10B981);
  static const backgroundColor = Color(0xFFF8FAFC);
  static const surfaceColor = Colors.white;
  static const textColor = Color(0xFF1E293B);
  static const mutedTextColor = Color(0xFF64748B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: "Inter", // Assuming Inter is available or default sans-serif
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        hintStyle: const TextStyle(color: mutedTextColor, fontSize: 14),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 24),
        titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
        bodyLarge: TextStyle(color: textColor, fontSize: 16),
        bodyMedium: TextStyle(color: textColor, fontSize: 14),
        labelMedium: TextStyle(color: mutedTextColor, fontSize: 12),
      ),
    );
  }
}
