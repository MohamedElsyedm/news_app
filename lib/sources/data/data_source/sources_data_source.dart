import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/shared/constants/api_constance.dart';
import 'package:news_app/sources/data/models/sources_response.dart';

class SourcesDataSource {
  Future<SourcesResponse> getSources(String categoryId) async {
    Uri uri = Uri.https(APIConstance.baseURL, APIConstance.sourceEndpoint, {
      "apiKey": APIConstance.apiKey,
      "category": categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }
}
