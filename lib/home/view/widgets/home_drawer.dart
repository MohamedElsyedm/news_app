import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/shared/app_theme.dart';
import 'package:news_app/shared/constants/constants_text.dart';
import 'package:news_app/shared/settings_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  VoidCallback goToHome;

  HomeDrawer({super.key, required this.goToHome});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<Language> languages = [
    Language(code: 'en', name: 'English'),
    Language(code: 'ar', name: 'العربية'),
  ];

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width * 0.7,
      color: AppTheme.black,
      child: Column(
        children: [
          Container(
            color: AppTheme.white,
            height: screenSize.height * 0.2,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              appLocalizations.newsApp,
              style: textTheme.titleLarge!.copyWith(
                color: AppTheme.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 16, top: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.goToHome();
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/home.svg'),
                      SizedBox(width: 8),
                      Text(appLocalizations.home, style: textTheme.labelLarge),
                    ],
                  ),
                ),
                Divider(height: 48, indent: 16, endIndent: 16),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/theme.svg'),
                    SizedBox(width: 8),
                    Text(appLocalizations.theme, style: textTheme.labelLarge),
                  ],
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(end: 16, top: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton(
                    underline: SizedBox(),
                    dropdownColor: AppTheme.black,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    iconEnabledColor: AppTheme.white,
                    iconDisabledColor: AppTheme.white,
                    isExpanded: true,
                    value: settingsProvider.themeCode,
                    items: [
                      DropdownMenuItem(
                        alignment: Alignment.center,
                        value: 'D',
                        child: Text(
                          'Dark',
                          style: textTheme.labelLarge!.copyWith(
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        alignment: Alignment.center,
                        value: 'L',
                        child: Text(
                          'Light',
                          style: textTheme.labelLarge!.copyWith(
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      settingsProvider.changeTheme(value);
                      print(value);
                    },
                  ),
                ),

                Divider(height: 48, indent: 16, endIndent: 16),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/language.svg'),
                    SizedBox(width: 8),
                    Text(
                      appLocalizations.language,
                      style: textTheme.labelLarge,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(end: 16, top: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton(
                    underline: SizedBox(),
                    dropdownColor: AppTheme.black,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    iconEnabledColor: AppTheme.white,
                    iconDisabledColor: AppTheme.white,
                    isExpanded: true,
                    value: settingsProvider.languageCode,
                    items: languages
                        .map(
                          (language) => DropdownMenuItem(
                            alignment: Alignment.center,
                            value: language.code,
                            child: Text(
                              language.name,
                              style: textTheme.labelLarge!.copyWith(
                                color: AppTheme.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (langCode) {
                      if (langCode == null) return;
                      settingsProvider.changeLanguage(langCode);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Language {
  String code;
  String name;

  Language({required this.code, required this.name});
}
