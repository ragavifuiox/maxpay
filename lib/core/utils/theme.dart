import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:maxpay/core/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider for SharedPreferences instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize in main.dart');
});

// Theme Notifier to handle persistence
class ThemeNotifier extends StateNotifier<ThemeMode> {
  final SharedPreferences _prefs;
  static const _themeKey = 'app_theme_mode';

  ThemeNotifier(this._prefs) : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() {
    final themeIndex = _prefs.getInt(_themeKey);
    if (themeIndex != null) {
      state = ThemeMode.values[themeIndex];
    }
  }

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _prefs.setInt(_themeKey, state.index);
  }

  void setTheme(ThemeMode mode) {
    state = mode;
    _prefs.setInt(_themeKey, mode.index);
  }
}

// Global Theme Provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeNotifier(prefs);
});

class AppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.clrPrimary,
    scaffoldBackgroundColor: AppColors.clrBg,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.light(
      primary: AppColors.clrPrimary,
      secondary: AppColors.clrSecondary,
      surface: AppColors.clrBg,
      onSurface: AppColors.clrTextblack,
      onSurfaceVariant: AppColors.clrTextgrey,
      surfaceContainer: AppColors.darkbgBlack,
      outline: AppColors.clrTextgrey,
      surfaceBright: AppColors.clrplceholder,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.clrBg,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.clrTextblack),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.clrTextblack),
      bodyLarge: TextStyle(color: AppColors.clrTextblack),
      bodyMedium: TextStyle(color: AppColors.clrTextblack),
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.clrPrimary,
    scaffoldBackgroundColor: AppColors.darkbgBlack,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.clrPrimary,
      secondary: AppColors.clrPrimary,
      surface: AppColors.darkbgBlack,
      surfaceContainer: AppColors.darkbgBlack,
      onSurface: AppColors.clrBg,
      onSurfaceVariant: AppColors.clrTextgrey,

      outline: AppColors.clrplceholder,
      surfaceBright: AppColors.darkplceholder,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkbgBlack,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.clrBg),
      bodyLarge: TextStyle(color: AppColors.clrBg),
      bodyMedium: TextStyle(color: AppColors.clrBg),
    ),
  );
}
