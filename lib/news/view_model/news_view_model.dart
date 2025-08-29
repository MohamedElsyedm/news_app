import 'package:flutter/widgets.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/news/data/repository/news_repository.dart';
import 'package:news_app/shared/service_locator.dart';

class NewsViewModel with ChangeNotifier {
  NewsRepository newsRepository = NewsRepository(ServiceLocator.newsDataSource);
  List<News> newsList = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getNews(String sourceId, String page, String searchText) async {
    isLoading = true;
    try {
      newsList = await newsRepository.getNews(sourceId, page, searchText);
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
