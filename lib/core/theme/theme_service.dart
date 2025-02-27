import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeService {
  static final _box = Hive.box('preferences');
  static const _key = 'isDarkMode';

  static bool get isDarkMode => _box.get(_key, defaultValue: false);

  static Future<void> toggleTheme() async {
    await _box.put(_key, !isDarkMode);
  }

  static ThemeData get theme => isDarkMode ? _darkTheme : _lightTheme;

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}
