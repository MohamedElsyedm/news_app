import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/news/data/repository/news_repository.dart';
import 'package:news_app/news/view_model/news_states.dart';
import 'package:news_app/shared/service_locator.dart';

class NewsViewModel extends Cubit<NewsState> {
  late NewsRepository newsRepository;
  NewsViewModel() : super(NewsInitState()) {
    newsRepository = NewsRepository(ServiceLocator.newsDataSource);
  }

  Future<void> getNews(String sourceId, String page, String searchText) async {
    emit(GetNewsLoading());
    try {
      List<News> newsList = await newsRepository.getNews(
        sourceId,
        page,
        searchText,
      );
      emit(GetNewsSuccess(newsList));
    } catch (error) {
      emit(GetNewsError(error.toString()));
    }
  }
}
