import 'package:flutter/material.dart';
import 'package:news_app/shared/service_locator.dart';
import 'package:news_app/sources/data/data_source/sources_api_data_source.dart';
import 'package:news_app/sources/data/models/source.dart';
import 'package:news_app/sources/repository/sources_repoistory.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesRepository sourcesRepository = SourcesRepository(
    ServiceLocator.sourcesDataSource,
  );

  List<Source> sources = []; //data state
  bool isLoading = false; // loading state
  String? errormessage; // error state

  Future<void> getSources(String categoryId) async {
    isLoading = true;
    try {
      sources = await sourcesRepository.getSources(categoryId);
    } catch (error) {
      errormessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
