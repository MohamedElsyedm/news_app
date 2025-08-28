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
  bool _isLoading = false;
  SourcesViewModel sourcesViewModel = SourcesViewModel();
  NewsViewModel newsViewModel = NewsViewModel();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    sourcesViewModel.getSources(widget.categoryID);
  }

  @override
  Widget build(BuildContext context) {
    List<News> allNewsList = [];
    int currentPage = 1;
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
            newsViewModel.getNews(
              viewModel.sources[currentIndex].id!,
              currentPage.toString(),
              widget.searchValue,
            );
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
                          _isLoading = true;
                          allNewsList.addAll(newsView.newsList);
                          _scrollController.addListener(() {
                            if (_scrollController.position.pixels ==
                                _scrollController.position.maxScrollExtent) {
                              if (newsViewModel.newsList.isEmpty) return;
                              newsViewModel.getNews(
                                viewModel.sources[currentIndex].id!,
                                (currentPage++).toString(),
                                widget.searchValue,
                              );
                            }
                          });
                          _isLoading = false;
                          return ListView.separated(
                            controller: _scrollController,
                            padding: EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            itemBuilder: (_, index) {
                              if (index < allNewsList.length) {
                                // Display the list item
                                return GestureDetector(
                                  onTap: () {
                                    showNewsBottomSheet(allNewsList[index]);
                                  },
                                  child: NewsItem(allNewsList[index]),
                                );
                              } else {
                                // Display the loading indicator at the end
                                return newsViewModel.newsList.isEmpty
                                    ? Center(
                                        child: Text(
                                          'End Of List',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20.0,
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                              }
                            },
                            separatorBuilder: (_, _) => SizedBox(height: 16),
                            itemCount: allNewsList.length + 1,
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
