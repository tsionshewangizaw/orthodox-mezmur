import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryGold = Color(0xFFFFD700);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color pureBlack = Color(0xFF000000);
  static const Color darkGray = Color(0xFF1A1A1A);
  static const Color surfaceBlack = Color(0xFF0D0D0D);
  static const Color cardBlack = Color(0xFF1A1A1A);

  static BoxDecoration premiumGradient = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF000000),
        Color(0xFF1A1A1A),
        Color(0xFF0D0D0D),
      ],
    ),
  );

  // BLACK THEME
  static ThemeData blackTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF000000),
    primaryColor: Color(0xFFFFD700),
    cardColor: Color(0xFF111111),
    textTheme:
        GoogleFonts.notoSerifEthiopicTextTheme(ThemeData.dark().textTheme)
            .copyWith(
      headlineMedium: TextStyle(
          color: Color(0xFFFFD700), fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.white, fontSize: 18),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFFFFD700),
        titleTextStyle: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 22,
            fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: Color(0xFFFFD700)),
  );

  // DARK THEME
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
    primaryColor: Color(0xFFFFD700),
    cardColor: Color(0xFF2A2A2A),
    textTheme:
        GoogleFonts.notoSerifEthiopicTextTheme(ThemeData.dark().textTheme)
            .copyWith(
      headlineMedium: TextStyle(
          color: Color(0xFFFFD700), fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.white, fontSize: 18),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFFFFD700),
        titleTextStyle: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 22,
            fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: Color(0xFFFFD700)),
  );

  // WHITE THEME
  static ThemeData whiteTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    primaryColor: Color(0xFF8B0000),
    cardColor: Color(0xFFF5F5F5),
    textTheme:
        GoogleFonts.notoSerifEthiopicTextTheme(ThemeData.light().textTheme)
            .copyWith(
      headlineMedium: TextStyle(
          color: Color(0xFF8B0000), fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.black, fontSize: 18),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF666666), fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF8B0000),
        titleTextStyle: TextStyle(
            color: Color(0xFF8B0000),
            fontSize: 22,
            fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: Color(0xFF8B0000)),
  );
// gold/ brown
  static ThemeData goldTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF3E2723),
    primaryColor: Color(0xFFFFD700),
    cardColor: Color(0xFF4E342E),
    textTheme:
        GoogleFonts.notoSerifEthiopicTextTheme(ThemeData.dark().textTheme)
            .copyWith(
      headlineMedium: TextStyle(
          color: Color(0xFFFFD700), fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color(0xFFFFF8DC), fontSize: 18),
      bodyLarge: TextStyle(color: Color(0xFFFFF8DC), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFFD2B48C), fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFFFFD700),
        titleTextStyle: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 22,
            fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: Color(0xFFFFD700)),
  );
  //midnight blue
  static ThemeData midnightTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF0D1B2A),
    primaryColor: Color(0xFFFFD700),
    cardColor: Color(0xFF1B2838),
    textTheme:
        GoogleFonts.notoSerifEthiopicTextTheme(ThemeData.dark().textTheme)
            .copyWith(
      headlineMedium: TextStyle(
          color: Color(0xFFFFD700), fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color(0xFFE0E6ED), fontSize: 18),
      bodyLarge: TextStyle(color: Color(0xFFE0E6ED), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF8899AA), fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFFFFD700),
        titleTextStyle: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 22,
            fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: Color(0xFFFFD700)),
  );

  //forest green

  static ThemeData forestTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF1B2E1B),
    primaryColor: Color(0xFFFFD700),
    cardColor: Color(0xFF2A3A2A),
    textTheme:
        GoogleFonts.notoSerifEthiopicTextTheme(ThemeData.dark().textTheme)
            .copyWith(
      headlineMedium: TextStyle(
          color: Color(0xFFFFD700), fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color(0xFFE8F5E9), fontSize: 18),
      bodyLarge: TextStyle(color: Color(0xFFE8F5E9), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFFA5D6A7), fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFFFFD700),
        titleTextStyle: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 22,
            fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: Color(0xFFFFD700)),
  );

  //royal purple
  static ThemeData royalTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF1A0A2E),
    primaryColor: Color(0xFFFFD700),
    cardColor: Color(0xFF2D1B4E),
    textTheme:
        GoogleFonts.notoSerifEthiopicTextTheme(ThemeData.dark().textTheme)
            .copyWith(
      headlineMedium: TextStyle(
          color: Color(0xFFFFD700), fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color(0xFFF3E5F5), fontSize: 18),
      bodyLarge: TextStyle(color: Color(0xFFF3E5F5), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFFCE93D8), fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFFFFD700),
        titleTextStyle: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 22,
            fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: Color(0xFFFFD700)),
  );

  // SEPIA THEME
  static ThemeData sepiaTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF4ECD8),
    primaryColor: Color(0xFF5B4636),
    cardColor: Color(0xFFE8DCC8),
    textTheme:
        GoogleFonts.notoSerifEthiopicTextTheme(ThemeData.light().textTheme)
            .copyWith(
      headlineMedium: TextStyle(
          color: Color(0xFF5B4636), fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color(0xFF3E2723), fontSize: 18),
      bodyLarge: TextStyle(color: Color(0xFF4E342E), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF6D4C41), fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF5B4636),
        titleTextStyle: TextStyle(
            color: Color(0xFF5B4636),
            fontSize: 22,
            fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: Color(0xFF5B4636)),
  );
}
