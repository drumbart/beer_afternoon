import 'package:beer_repository/beer_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_data_api/random_data_api.dart' as random_data_api;
import 'package:test/test.dart';

class MockRandomDataApiClient extends Mock implements random_data_api.RandomDataApiClient {}

class MockBeer extends Mock implements random_data_api.Beer {}

void main() {
  group('BeerRepository', () {
    late random_data_api.RandomDataApiClient randomDataApiClient;
    late BeerRepository beerRepository;

    setUp(() {
      randomDataApiClient = MockRandomDataApiClient();
      beerRepository = BeerRepository(randomDataApiClient: randomDataApiClient);
    });

    group('constructor', () {
      test('instantiates internal random_data_api_client when not injected', () => expect(BeerRepository(), isNotNull));
    });

    group('getBeer', () {
      test('throws when getBeer fails', () {
        final exception = Exception('getBeer request failed');
        when(() => randomDataApiClient.getBeer()).thenThrow(exception);
        expect(() async => beerRepository.getBeer(), throwsA(isA<BeerFetchFailed>()));
      });

      test('returns a correct Beer on success', () async {
        const id = 1;
        const uid = 'abc';
        const name = 'Ten FIDY';
        const brand = 'Pabst Blue Ribbon';
        const style = 'Belgian And French Ale';
        const hop = 'Simcoe';
        const yeast = '1010 - American Wheat';
        const malts = 'Chocolate';
        const ibu = '56 IBU';
        const alcohol = '8.5%';
        const blg = '6.7°Blg';

        final beer = MockBeer();
        when(() => beer.id).thenReturn(id);
        when(() => beer.uid).thenReturn(uid);
        when(() => beer.name).thenReturn(name);
        when(() => beer.brand).thenReturn(brand);
        when(() => beer.style).thenReturn(style);
        when(() => beer.hop).thenReturn(hop);
        when(() => beer.yeast).thenReturn(yeast);
        when(() => beer.malts).thenReturn(malts);
        when(() => beer.ibu).thenReturn(ibu);
        when(() => beer.alcohol).thenReturn(alcohol);
        when(() => beer.blg).thenReturn(blg);

        when(() => randomDataApiClient.getBeer()).thenAnswer((_) async => beer);

        final actual = await beerRepository.getBeer();
        expect(
          actual,
          isA<random_data_api.Beer>()
              .having((b) => b.id, 'object id', id)
              .having((b) => b.uid, 'object uid', uid)
              .having((b) => b.brand, 'beer brand', brand)
              .having((b) => b.name, 'beer name', name)
              .having((b) => b.style, 'beer style', style)
              .having((b) => b.hop, 'hop type', hop)
              .having((b) => b.yeast, 'yeast type', yeast)
              .having((b) => b.malts, 'malts type', malts)
              .having((b) => b.ibu, 'ibu', ibu)
              .having((b) => b.alcohol, 'alcohol qty', alcohol)
              .having((b) => b.blg, 'blg', blg),
        );
      });
    });
  });
}
