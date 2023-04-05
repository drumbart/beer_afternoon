import 'package:random_data_api/random_data_api.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('RandomDataApiClient', () {
    late http.Client httpClient;
    late RandomDataApiClient apiClient;

    setUpAll(() => registerFallbackValue(FakeUri()));
    setUp(() {
      httpClient = MockHttpClient();
      apiClient = RandomDataApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('defaults to httpClient', () => expect(RandomDataApiClient(), isNotNull));
    });

    group('getBeer', () {
      test('makes a correct https request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await apiClient.getBeer();
        } catch (_) {}

        verify(
          () => httpClient.get(
            Uri.https(RandomDataApiClient.baseUrl, RandomDataApiClient.beersEndpoint),
          ),
        ).called(1);
      });

      test('throws BeerRequestFailure when response IS NOT 200', () {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(() => apiClient.getBeer(), throwsA(isA<BeerRequestFailure>()));
      });
    });

    test('returns a correct object on success', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(
          '''
          {
          "id": 1,
          "uid": "abc",
          "brand": "Pabst Blue Ribbon",
          "name": "Ten FIDY",
          "style": "Belgian And French Ale",
          "hop": "Simcoe",
          "yeast": "1010 - American Wheat",
          "malts": "Chocolate",
          "ibu": "56 IBU",
          "alcohol": "8.5%",
          "blg": "6.7°Blg"
          }
          ''');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      final actual = await apiClient.getBeer();
      expect(
        actual,
        isA<Beer>()
            .having((b) => b.id, 'object id', 1)
            .having((b) => b.uid, 'object uid', 'abc')
            .having((b) => b.brand, 'beer brand', 'Pabst Blue Ribbon')
            .having((b) => b.name, 'beer name', 'Ten FIDY')
            .having((b) => b.style, 'beer style', 'Belgian And French Ale')
            .having((b) => b.hop, 'hop type', 'Simcoe')
            .having((b) => b.yeast, 'yeast type', '1010 - American Wheat')
            .having((b) => b.malts, 'malts type', 'Chocolate')
            .having((b) => b.ibu, 'ibu', '56 IBU')
            .having((b) => b.alcohol, 'alcohol qty', '8.5%')
            .having((b) => b.blg, 'blg', '6.7°Blg'),
      );
    });
  });
}
