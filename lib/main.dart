import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/shared/app-bloc_observer.dart';
import 'package:news_app/shared/app_theme.dart';
import 'package:news_app/home/view/screens/home_screen.dart';
import 'package:news_app/shared/settings_provider.dart';
import 'package:provider/provider.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {HomeScreen.routName: (_) => HomeScreen()},
      initialRoute: HomeScreen.routName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingsProvider.languageCode),
    );
  }
}
