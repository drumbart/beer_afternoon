import 'package:json_annotation/json_annotation.dart';

part 'beer.g.dart';

@JsonSerializable()
class Beer {
  final int id;
  final String uid;
  final String brand;
  final String name;
  final String style;
  final String hop;
  final String yeast;
  final String malts;
  final String ibu;
  final String alcohol;
  final String blg;

  const Beer({
    required this.id,
    required this.uid,
    required this.brand,
    required this.name,
    required this.style,
    required this.hop,
    required this.yeast,
    required this.malts,
    required this.ibu,
    required this.alcohol,
    required this.blg,
  });

  static const empty = Beer(
    id: -1,
    uid: '-',
    brand: '-',
    name: '-',
    style: '-',
    hop: '-',
    yeast: '-',
    malts: '-',
    ibu: '-',
    alcohol: '-',
    blg: '-',
  );

  factory Beer.fromJson(Map<String, dynamic> json) => _$BeerFromJson(json);
}
