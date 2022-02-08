import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:providerskeleton/core/utils/themes/dark.dart';
import 'package:providerskeleton/core/utils/themes/light.dart';
import 'package:providerskeleton/core/utils/themes/yellow.dart';

// this is theme provider for update theme

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  ThemeData light = AppThemes.light;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance?.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

  void changeTheme(ThemeData themeData) {
    light = themeData;
    notifyListeners();
  }
}

// all theme defined here

class AppThemes {
  static ThemeData light = lightTheme;
  static ThemeData dark = darkTheme;
  static ThemeData yellow = yellowTheme;
}
