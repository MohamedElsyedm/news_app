import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/shared/settings_provider.dart';

class ConstantsText {
  static bool isDark = SettingsProvider().themeMode == ThemeMode.dark;
  static String generalImage = isDark ? 'general' : 'general_dark';
  static String technologyImage = isDark ? 'technology' : 'technology_dark';
  static String sportsImage = isDark ? 'sports' : 'sports_dark';
  static String scienceImage = isDark ? 'science' : 'science_dark';
  static String healthImage = isDark ? 'health' : 'health_dark';
  static String entertainmentImage = isDark
      ? 'entertainment'
      : 'entertainment_dark';
  static String businessImage = isDark ? 'business' : 'business_dark';
  static const String emptyImage =
      'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';
}
