import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/shared/constants/api_constance.dart';
import 'package:news_app/sources/data/data_source/sources_data_source.dart';
import 'package:news_app/sources/data/models/source.dart';
import 'package:news_app/sources/data/models/sources_response.dart';

class SourcesAPIDataSource implements SourcesDataSource {
  @override
  Future<List<Source>> getSources(String categoryId) async {
    Uri uri = Uri.https(APIConstance.baseURL, APIConstance.sourceEndpoint, {
      "apiKey": APIConstance.apiKey,
      "category": categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    if (sourcesResponse.status == 'ok' && sourcesResponse.sources != null) {
      return sourcesResponse.sources!;
    } else {
      throw Exception('failed to get sources');
    }
  }
}
