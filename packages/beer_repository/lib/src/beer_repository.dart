import 'package:random_data_api/random_data_api.dart';

class BeerFetchFailed implements Exception {}

class BeerRepository {
  final RandomDataApiClient _randomDataApiClient;

  BeerRepository({RandomDataApiClient? randomDataApiClient}) : _randomDataApiClient = randomDataApiClient ?? RandomDataApiClient();

  Future<Beer> getBeer() async {
    try {
      return await _randomDataApiClient.getBeer();
    } catch (_) {
      throw BeerFetchFailed();
    }
  }
}