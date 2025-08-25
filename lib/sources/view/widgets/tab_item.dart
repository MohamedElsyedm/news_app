import 'package:flutter/material.dart';
import 'package:news_app/sources/data/models/source.dart';

class TabItem extends StatelessWidget {
  Source source;
  bool isSelected;

  TabItem({super.key, required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      source.id!,
      style: isSelected ? textTheme.titleMedium : textTheme.titleSmall,
    );
  }
}
