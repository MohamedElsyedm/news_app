import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String themeCode = 'L';
  String languageCode = 'en';

  void changeTheme(String theme) {
    if (themeCode == theme) return;
    themeCode = theme;
    themeMode = themeCode == 'L' ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void changeLanguage(String language) {
    if (languageCode == language) return;
    languageCode = language;
    notifyListeners();
  }
}
