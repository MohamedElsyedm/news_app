import 'package:flutter/material.dart';
import 'package:news_app/sources/data/data_source/sources_data_source.dart';
import 'package:news_app/sources/data/models/source.dart';
import 'package:news_app/sources/data/models/sources_response.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesDataSource dataSource = SourcesDataSource();
  List<Source> sources = []; //data state
  bool isLoading = false; // loading state
  String? errormessage; // error state

  Future<void> getSources(String categoryId) async {
    isLoading = true;
    try {
      SourcesResponse response = await dataSource.getSources(categoryId);
      if (response.status == 'ok' && response.sources != null) {
        sources = response.sources!;
      } else {
        errormessage = 'Failed to get sources';
        print(response.status);
      }
    } catch (error) {
      errormessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
