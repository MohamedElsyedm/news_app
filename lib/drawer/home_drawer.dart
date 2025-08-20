import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/app_theme.dart';

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
  List<ThemeClass> themeModes = [
    ThemeClass(name: 'Dark', themeMode: ThemeMode.dark),
    ThemeClass(name: 'Light', themeMode: ThemeMode.light),
  ];

  String languageCode = 'ar';
  String themeName = 'Dark';

  @override
  Widget build(BuildContext context) {
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
              'News App',
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
                      Text('Home', style: textTheme.labelLarge),
                    ],
                  ),
                ),
                Divider(height: 48, indent: 16, endIndent: 16),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/theme.svg'),
                    SizedBox(width: 8),
                    Text('Theme', style: textTheme.labelLarge),
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
                    value: themeName,
                    items: themeModes
                        .map(
                          (theme) => DropdownMenuItem(
                            alignment: Alignment.center,
                            value: theme.name,
                            child: Text(
                              theme.name,
                              style: textTheme.labelLarge!.copyWith(
                                color: AppTheme.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (theme) {
                      if (theme == null) return;
                      changeTheme(theme.toString());
                    },
                  ),
                ),

                Divider(height: 48, indent: 16, endIndent: 16),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/language.svg'),
                    SizedBox(width: 8),
                    Text('Language', style: textTheme.labelLarge),
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
                    value: languageCode,
                    items: languages
                        .map(
                          (Language) => DropdownMenuItem(
                            alignment: Alignment.center,
                            value: Language.code,
                            child: Text(
                              Language.name,
                              style: textTheme.labelLarge!.copyWith(
                                color: AppTheme.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (langCode) {
                      if (langCode == null) return;
                      changeLanguage(langCode.toString());
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

  void changeLanguage(String language) {
    if (languageCode == language) return;
    languageCode = language;
    setState(() {});
  }

  void changeTheme(String theme) {
    if (themeName == theme) return;
    themeName = theme;
    setState(() {});
  }
}

class Language {
  String code;
  String name;

  Language({required this.code, required this.name});
}

class ThemeClass {
  String name;
  ThemeMode themeMode;

  ThemeClass({required this.name, required this.themeMode});
}
