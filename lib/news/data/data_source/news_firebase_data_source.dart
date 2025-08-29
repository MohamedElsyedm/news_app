import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/news/data/models/news.dart';

class NewsFirebaseDataSource implements NewsDataSource {
  @override
  Future<List<News>> getNews(
    String sourceId,
    String page, [
    String q = '',
  ]) async {
    return [];
  }
}
