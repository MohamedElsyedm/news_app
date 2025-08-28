import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/shared/app_theme.dart';
import 'package:news_app/shared/constants/constants_text.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.onSearchClosed,
    required this.onChanged,
    required this.myController,
  });

  VoidCallback onSearchClosed;
  Function(String value) onChanged;
  TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: myController,
        onChanged: onChanged,
        style: TextStyle(
          color: ConstantsText.isDark ? AppTheme.white : AppTheme.black,
        ),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.search,
          prefixIcon: Icon(Icons.search_outlined, size: 24),
          suffixIcon: IconButton(
            onPressed: () {
              onSearchClosed();
              myController.clear();
            },
            icon: Icon(Icons.close_rounded, size: 24),
          ),
        ),
        cursorColor: ConstantsText.isDark ? AppTheme.white : AppTheme.black,
      ),
    );
  }
}
