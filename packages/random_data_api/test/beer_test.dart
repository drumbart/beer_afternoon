import 'package:random_data_api/random_data_api.dart';
import 'package:test/test.dart';

void main() {
  group('Beer', () {
    group('fromJson', () {
      test('returns correct Beer object', () {
        const id = 1;
        const uid = '123';
        const brand = 'Pabst Blue Ribbon';
        const name = 'Ten FIDY';
        const style = 'Belgian And French Ale';
        const hop = 'Simcoe';
        const yeast = '1010 - American Wheat';
        const malts = 'Chocolate';
        const ibu = '56 IBU';
        const alcohol = '8.5%';
        const blg = '6.7°Blg';

        expect(
          Beer.fromJson(<String, dynamic>{
            'id': id,
            'uid': uid,
            'brand': brand,
            'name': name,
            'style': style,
            'hop': hop,
            'yeast': yeast,
            'malts': malts,
            'ibu': ibu,
            'alcohol': alcohol,
            'blg': blg,
          }),
          isA<Beer>()
              .having((b) => b.id, 'id', id)
              .having((b) => b.uid, 'uid', uid)
              .having((b) => b.brand, 'brand', brand)
              .having((b) => b.name, 'name', name)
              .having((b) => b.style, 'style', style)
              .having((b) => b.hop, 'hop', hop)
              .having((b) => b.yeast, 'yeast', yeast)
              .having((b) => b.malts, 'malts', malts)
              .having((b) => b.ibu, 'ibu', ibu)
              .having((b) => b.alcohol, 'alcohol', alcohol)
              .having((b) => b.blg, 'blg', blg),
        );
      });
    });
  });
}
