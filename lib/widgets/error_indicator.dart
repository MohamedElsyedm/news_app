import 'package:flutter/material.dart';
import 'package:news_app/constants/constants_text.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(ConstantsText.defaultErrorMessage));
  }
}
