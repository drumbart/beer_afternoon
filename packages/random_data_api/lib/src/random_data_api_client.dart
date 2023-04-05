import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/beer.dart';

class BeerRequestFailure implements Exception {}

class RandomDataApiClient {
  static const baseUrl = 'random-data-api.com';
  static const beersEndpoint = 'api/v2/beers';
  final http.Client _httpClient;

  RandomDataApiClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  Future<Beer> getBeer() async {
    final request = Uri.https(baseUrl, beersEndpoint);
    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw BeerRequestFailure();
    }

    final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;
    return Beer.fromJson(bodyJson);
  }
}
