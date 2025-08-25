import 'package:flutter/widgets.dart';
import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/news/data/models/news_response.dart';

class NewsViewModel with ChangeNotifier {
  NewsDataSource newsDataSource = NewsDataSource();
  List<News> newsList = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getNews(String sourceId) async {
    isLoading = true;
    try {
      NewsResponse response = NewsResponse();
      if (response.status == 'ok' && response.newsList != null) {
        newsList = response.newsList!;
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
