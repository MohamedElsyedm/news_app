import 'package:flutter/widgets.dart';
import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/news/data/models/news.dart';

class NewsViewModel with ChangeNotifier {
  List<News> newsList = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getNews(String sourceId, String page, String searchText) async {
    isLoading = true;
    try {
      newsList = await NewsDataSource.getNews(sourceId, page, searchText);
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
