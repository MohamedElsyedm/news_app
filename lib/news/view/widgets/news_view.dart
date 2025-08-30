import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news/view_model/news_states.dart';
import 'package:news_app/shared/app_theme.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/news/view_model/news_view_model.dart';
import 'package:news_app/sources/data/models/source.dart';
import 'package:news_app/news/view/widgets/news_item.dart';
import 'package:news_app/sources/view/widgets/tab_item.dart';
import 'package:news_app/sources/view_model/sources_states.dart';
import 'package:news_app/sources/view_model/sources_view_model.dart';
import 'package:news_app/shared/widgets/error_indicator.dart';
import 'package:news_app/shared/widgets/loading_indicator.dart';
import 'package:news_app/shared/widgets/news_bottom_sheet.dart';

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
    return BlocProvider(
      create: (context) => sourcesViewModel,
      child: BlocBuilder<SourcesViewModel, SourcesState>(
        builder: (_, state) {
          if (state is GetSourcesLoading) {
            return LoadingIndicator();
          } else if (state is GetSourcesError) {
            return ErrorIndicator(state.message);
          } else if (state is GetSourcesSuccess) {
            List<Source> sources = state.sources;
            newsViewModel.getNews(
              state.sources[currentIndex].id!,
              currentPage.toString(),
              widget.searchValue,
            );
            _scrollController.addListener(() {
              // Check if the user has scrolled to the end of the list
              if (_scrollController.position.pixels ==
                  _scrollController.position.maxScrollExtent) {
                _isLoading = true;
                newsViewModel.getNews(
                  state.sources[currentIndex].id!,
                  (currentPage++).toString(),
                  widget.searchValue,
                );
              }
            });
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
                  child: BlocProvider(
                    create: (context) => newsViewModel,
                    child: BlocBuilder<NewsViewModel, NewsState>(
                      builder: (_, state) {
                        if (state is GetNewsLoading) {
                          return LoadingIndicator();
                        } else if (state is GetNewsError) {
                          return ErrorIndicator(state.message);
                        } else if (state is GetNewsSuccess) {
                          allNewsList.addAll(state.newsList);
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
                                return state.newsList.isEmpty
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
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return SizedBox();
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
