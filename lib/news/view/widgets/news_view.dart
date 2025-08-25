import 'package:flutter/material.dart';
import 'package:news_app/shared/app_theme.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/news/view_model/news_view_model.dart';
import 'package:news_app/sources/data/models/source.dart';
import 'package:news_app/news/view/widgets/news_item.dart';
import 'package:news_app/sources/view/widgets/tab_item.dart';
import 'package:news_app/sources/view_model/sources_view_model.dart';
import 'package:news_app/shared/widgets/error_indicator.dart';
import 'package:news_app/shared/widgets/loading_indicator.dart';
import 'package:news_app/shared/widgets/news_bottom_sheet.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  String categoryID;
  String searchValue;

  NewsView(this.categoryID, this.searchValue, {super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  SourcesViewModel sourcesViewModel = SourcesViewModel();
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  void initState() {
    super.initState();
    sourcesViewModel.getSources(widget.categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sourcesViewModel,
      child: Consumer<SourcesViewModel>(
        builder: (_, viewModel, _) {
          if (viewModel.isLoading) {
            return LoadingIndicator();
          } else if (viewModel.errormessage != null) {
            return ErrorIndicator(viewModel.errormessage!);
          } else {
            List<Source> sources = viewModel.sources;
            newsViewModel.getNews(viewModel.sources[currentIndex].id!);
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
                  child: ChangeNotifierProvider(
                    create: (context) => newsViewModel,
                    child: Consumer<NewsViewModel>(
                      builder: (_, newsView, _) {
                        if (newsView.isLoading) {
                          return LoadingIndicator();
                        } else if (newsView.errorMessage != null) {
                          return ErrorIndicator(newsView.errorMessage!);
                        } else {
                          List<News> newsList = newsView.newsList;

                          return ListView.separated(
                            padding: EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
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
                ),
              ],
            );
          }
        },
      ),
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
/*
 future: APIService.getNews(
                        sources[currentIndex].id!,
                        '1',
                        '5',
                        widget.searchValue,
                      ),
 */