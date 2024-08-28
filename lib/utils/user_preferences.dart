import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _keyThemeMode = 'theme_mode';

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeMode, mode.index);
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt(_keyThemeMode);

    if (themeIndex != null) {
      return ThemeMode.values[themeIndex];
    } else {
      return ThemeMode.system;
    }
  }
}
