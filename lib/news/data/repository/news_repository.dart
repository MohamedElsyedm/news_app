import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/news/data/models/news.dart';

class NewsRepository {
  NewsDataSource newsDataSource;
  NewsRepository(this.newsDataSource);

  Future<List<News>> getNews(
    String sourceId,
    String page,
    String searchText,
  ) async {
    return newsDataSource.getNews(sourceId, page, searchText);
  }
}
