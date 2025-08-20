import 'news.dart';

class NewsResponse {
  String? status;
  int? totalResults;
  List<News>? newsList;

  NewsResponse({this.status, this.totalResults, this.newsList});

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    status: json['status'] as String?,
    totalResults: json['totalResults'] as int?,
    newsList: (json['articles'] as List<dynamic>?)
        ?.map((e) => News.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'totalResults': totalResults,
    'articles': newsList?.map((e) => e.toJson()).toList(),
  };
}
