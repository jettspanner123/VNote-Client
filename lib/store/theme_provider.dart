import "package:client/library/theme.dart";
import "package:flutter/material.dart";

class ThemeModel extends ChangeNotifier {
  ThemeData _currentTheme = lightMode;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == lightMode ? darkMode : lightMode;
    notifyListeners();
  }
}
