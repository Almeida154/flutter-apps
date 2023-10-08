import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          background: Color(0xFF000000),
          onBackground: Color(0xFFFFFFFF),
          primary: Color(0xFFE61759),
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFFB6002B),
          onSecondary: Color(0xFFFFFFFF),
          surface: Color(0xFF1B1C21),
          onSurface: Color(0xFFF6F6F6),
          error: Colors.red,
          onError: Colors.redAccent,
        ));
  }
}
