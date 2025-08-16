import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/news/news_item.dart';
import 'package:news_app/news/tab_item.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List<SourceModel> sources = List.generate(
    10,
    (index) => SourceModel(id: '$index', name: 'Source $index'),
  );
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: sources.length,
          child: TabBar(
            isScrollable: true,
            dividerColor: Colors.transparent,
            indicatorColor: AppTheme.white,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsetsDirectional.only(end: 16),
            padding: EdgeInsetsDirectional.only(start: 16),
            tabs: sources
                .map(
                  (source) => TabItem(
                    source: source,
                    isSelected: sources.indexOf(source) == currentIndex,
                  ),
                )
                .toList(),
            onTap: (index) {
              if (currentIndex == index) return;
              currentIndex = index;
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            itemBuilder: (_, index) => NewsItem(),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
