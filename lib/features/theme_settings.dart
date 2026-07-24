import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/app_theme.dart';

class ThemeSettings extends ChangeNotifier {
  static const String _themeKey = 'selected_theme';

  ThemeMode _themeMode = ThemeMode.dark;
  String _selectedTheme = 'Dark';

  ThemeMode get themeMode => _themeMode;
  String get selectedTheme => _selectedTheme;

  ThemeSettings() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedTheme = prefs.getString(_themeKey) ?? 'Dark';
    _applyTheme(_selectedTheme);
    notifyListeners();
  }

  void setTheme(String theme) async {
    _selectedTheme = theme;
    _applyTheme(theme);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
    notifyListeners();
  }

  void _applyTheme(String theme) {
    switch (theme) {
      case 'Black':
        _themeMode = ThemeMode.dark;
        break;
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'White':
        _themeMode = ThemeMode.light;
        break;
      case 'Sepia':
        _themeMode = ThemeMode.light;
        break;
    }
  }

  ThemeData getThemeData(String theme) {
    switch (theme) {
      case 'Black':
        return AppTheme.blackTheme;
      case 'Dark':
        return AppTheme.darkTheme;
      case 'White':
        return AppTheme.whiteTheme;
      case 'Sepia':
        return AppTheme.sepiaTheme;
      case 'Gold':
        return AppTheme.goldTheme;
      case 'Midnight':
        return AppTheme.midnightTheme;
      case 'Forest':
        return AppTheme.forestTheme;
      case 'Royal':
        return AppTheme.royalTheme;
      default:
        return AppTheme.darkTheme;
    }
  }

  // Black Theme
  static final ThemeData blackTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF000000),
    primaryColor: Color(0xFFFFD700),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFFFD700),
      secondary: Color(0xFFFFD700),
      surface: Color(0xFF0D0D0D),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Color(0xFFFFD700),
      titleTextStyle: TextStyle(
          color: Color(0xFFFFD700), fontSize: 22, fontWeight: FontWeight.bold),
    ),
    cardColor: Color(0xFF1A1A1A),
    textTheme: TextTheme(
      headlineMedium:
          TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.grey[400]),
    ),
    iconTheme: IconThemeData(color: Color(0xFFFFD700)),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
    primaryColor: Color(0xFFFFD700),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFFFD700),
      secondary: Color(0xFFFFD700),
      surface: Color(0xFF0D0D0D),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Color(0xFFFFD700),
      titleTextStyle: TextStyle(
          color: Color(0xFFFFD700), fontSize: 22, fontWeight: FontWeight.bold),
    ),
    cardColor: Color(0xFF2A2A2A),
    textTheme: TextTheme(
      headlineMedium:
          TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.grey[400]),
    ),
    iconTheme: IconThemeData(color: Color(0xFFFFD700)),
  );

  // White Theme
  static final ThemeData whiteTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    primaryColor: Color(0xFF8B0000),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF8B0000),
      secondary: Color(0xFFD4AF37),
      surface: Color(0xFFF5F5F5),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Color(0xFF8B0000),
      titleTextStyle: TextStyle(
          color: Color(0xFF8B0000), fontSize: 22, fontWeight: FontWeight.bold),
    ),
    cardColor: Colors.white,
    textTheme: TextTheme(
      headlineMedium:
          TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.grey[700]),
    ),
    iconTheme: IconThemeData(color: Color(0xFF8B0000)),
  );

  // Sepia Theme
  static final ThemeData sepiaTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF4ECD8),
    primaryColor: Color(0xFF5B4636),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF5B4636),
      secondary: Color(0xFF8B7355),
      surface: Color(0xFFE8DCC8),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Color(0xFF5B4636),
      titleTextStyle: TextStyle(
          color: Color(0xFF5B4636), fontSize: 22, fontWeight: FontWeight.bold),
    ),
    cardColor: Color(0xFFE8DCC8),
    textTheme: TextTheme(
      headlineMedium:
          TextStyle(color: Color(0xFF5B4636), fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color(0xFF3E2723)),
      bodyLarge: TextStyle(color: Color(0xFF4E342E)),
      bodyMedium: TextStyle(color: Color(0xFF6D4C41)),
    ),
    iconTheme: IconThemeData(color: Color(0xFF5B4636)),
  );
}
