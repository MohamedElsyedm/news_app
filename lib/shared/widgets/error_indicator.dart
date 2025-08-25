import 'package:flutter/material.dart';
import 'package:news_app/shared/constants/constants_text.dart';

class ErrorIndicator extends StatelessWidget {
  ErrorIndicator([this.message = ConstantsText.defaultErrorMessage]);

  String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
