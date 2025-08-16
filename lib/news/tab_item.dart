import 'package:flutter/material.dart';
import 'package:news_app/models/source_model.dart';

class TabItem extends StatelessWidget {
  SourceModel source;
  bool isSelected;

  TabItem({required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      source.name,
      style: isSelected ? textTheme.titleMedium : textTheme.titleSmall,
    );
  }
}
