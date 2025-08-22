import 'package:flutter/material.dart';
import 'package:news_app/api/api_service.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/constants/constants_text.dart';
import 'package:news_app/models/news_response/news.dart';
import 'package:news_app/models/sources_response/source.dart';
import 'package:news_app/models/sources_response/sources_response.dart';
import 'package:news_app/news/news_item.dart';
import 'package:news_app/news/tab_item.dart';
import 'package:news_app/widgets/error_indicator.dart';
import 'package:news_app/widgets/loading_indicator.dart';
import 'package:news_app/widgets/news_bottom_sheet.dart';

class NewsView extends StatefulWidget {
  String categoryID;
  String searchValue;

  NewsView(this.categoryID, this.searchValue, {super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  // called once
  late Future<SourcesResponse> futureSourcesResponse = APIService.getSources(
    widget.categoryID,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureSourcesResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data?.status != 'ok') {
          return ErrorIndicator();
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];
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
                child: FutureBuilder(
                  future: APIService.getNews(
                    sources[currentIndex].id!,
                    '1',
                    '5',
                    widget.searchValue,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingIndicator();
                    } else if (snapshot.hasError ||
                        snapshot.data?.status != 'ok') {
                      return ErrorIndicator();
                    } else {
                      List<News> newsList = snapshot.data?.newsList ?? [];

                      return ListView.separated(
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () {
                            showNewsBottomSheet(newsList[index]);
                          },
                          child: NewsItem(newsList[index]),
                        ),
                        separatorBuilder: (_, _) => SizedBox(height: 16),
                        itemCount: newsList.length,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future showNewsBottomSheet(News newsItem) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return NewsBottomSheet(newsItem);
      },
    );
  }
}
