import 'package:flutter/material.dart';
import 'package:news_app/sources/data/data_source/sources_data_source.dart';
import 'package:news_app/sources/data/models/source.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesDataSource dataSource = SourcesDataSource();
  List<Source> sources = []; //data state
  bool isLoading = false; // loading state
  String? errormessage; // error state

  Future<void> getSources(String categoryId) async {
    isLoading = true;
    try {
      sources = await dataSource.getSources(categoryId);
    } catch (error) {
      errormessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
