import 'package:news_app/sources/data/data_source/sources_api_data_source.dart';
import 'package:news_app/sources/data/data_source/sources_data_source.dart';
import 'package:news_app/sources/data/models/source.dart';

class SourcesRepository {
  SourcesDataSource sourcesDataSource;
  SourcesRepository(this.sourcesDataSource);
  Future<List<Source>> getSources(String categoryID) {
    return sourcesDataSource.getSources(categoryID);
  }
}
