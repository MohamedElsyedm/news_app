import 'package:flutter/widgets.dart';
import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/news/data/models/news_response.dart';

class NewsViewModel with ChangeNotifier {
  NewsDataSource dataSource = NewsDataSource();
  List<News> newsList = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getNews(String sourceId, String page, String searchValue) async {
    isLoading = true;
    try {
      NewsResponse response = await dataSource.getNews(
        sourceId,
        page,

        searchValue,
      );
      if (response.status == 'ok' && response.newsList != null) {
        newsList = response.newsList!;
        print(newsList.length);
      } else {
        errorMessage = 'Failed To Get News';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
