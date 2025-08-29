import 'dart:convert';

// top level function
import 'package:http/http.dart' as http;
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/shared/constants/api_constance.dart';
import 'package:news_app/news/data/models/news_response.dart';

class NewsDataSource {
  static Future<List<News>> getNews(
    String sourceId,
    String page, [
    String q = '',
  ]) async {
    Uri uri = Uri.https(APIConstance.baseURL, APIConstance.newsEndpoint, {
      "apiKey": APIConstance.apiKey,
      "sources": sourceId,
      "page": page,
      "pageSize": '5',
      "q": q,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    if (newsResponse.status == 'ok' && newsResponse.newsList != null) {
      return newsResponse.newsList!;
    } else {
      throw Exception('Failed to get News');
    }
  }
}
