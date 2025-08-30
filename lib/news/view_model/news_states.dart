import 'package:news_app/news/data/models/news.dart';

abstract class NewsState {}

class NewsInitState extends NewsState {}

class GetNewsLoading extends NewsState {}

class GetNewsError extends NewsState {
  String message;
  GetNewsError(this.message);
}

class GetNewsSuccess extends NewsState {
  List<News> newsList;
  GetNewsSuccess(this.newsList);
}
