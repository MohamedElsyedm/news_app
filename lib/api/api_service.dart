import 'dart:convert';

// top level function
import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constance.dart';
import 'package:news_app/models/news_response/news_response.dart';
import 'package:news_app/models/sources_response/sources_response.dart';

class APIService {
  static Future<SourcesResponse> getSources(String categoryId) async {
    Uri uri = Uri.https(APIConstance.baseURL, APIConstance.sourceEndpoint, {
      "apiKey": APIConstance.apiKey,
      "category": categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }

  static Future<NewsResponse> getNews(String sourceId) async {
    Uri uri = Uri.https(APIConstance.baseURL, APIConstance.newsEndpoint, {
      "apiKey": APIConstance.apiKey,
      "sources": sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}
