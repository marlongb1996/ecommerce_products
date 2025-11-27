import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF1E88E5),
  scaffoldBackgroundColor: const Color(0xFFF9FAFB),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF1E88E5),
    onPrimary: Colors.white,
    secondary: Color(0xFFFFA726),
    background: Color(0xFFF9FAFB),
    surface: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF212121)),
    bodyMedium: TextStyle(color: Color(0xFF616161)),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFFFFB74D),
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFFFB74D),
    onPrimary: Color(0xFF121212),
    secondary: Color(0xFF90CAF9),
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Color(0xFFBDBDBD)),
  ),
);
