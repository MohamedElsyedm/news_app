import 'package:news_app/news/data/models/news.dart';

abstract class NewsDataSource {
  Future<List<News>> getNews(String sourceId, String page, [String q = '']);
}
