import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/shared/constants/constants_text.dart';

class ErrorIndicator extends StatelessWidget {
  ErrorIndicator([this.message]);

  String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message ?? AppLocalizations.of(context)!.someThingWentWrong),
    );
  }
}
