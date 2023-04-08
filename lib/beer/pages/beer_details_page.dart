import 'package:beer_afternoon/extensions/build_context.dart';
import 'package:beer_repository/beer_repository.dart';
import 'package:flutter/material.dart';

class BeerDetailsPage extends StatelessWidget {
  final Beer beer;

  const BeerDetailsPage._(this.beer);

  static Route<void> route(Beer beer) {
    return MaterialPageRoute<void>(
      builder: (_) => BeerDetailsPage._(beer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Align(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                _DetailRowWidget(name: context.strings.name, value: beer.name),
                _DetailRowWidget(name: context.strings.brand, value: beer.brand),
                _DetailRowWidget(name: context.strings.style, value: beer.style),
                _DetailRowWidget(name: context.strings.hop, value: beer.hop),
                _DetailRowWidget(name: context.strings.yeast, value: beer.yeast),
                _DetailRowWidget(name: context.strings.malts, value: beer.malts),
                _DetailRowWidget(name: context.strings.ibu, value: beer.ibu),
                _DetailRowWidget(name: context.strings.alcohol, value: beer.alcohol),
                _DetailRowWidget(name: context.strings.blg, value: beer.blg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailRowWidget extends StatelessWidget {
  final String name;
  final String value;

  const _DetailRowWidget({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name:',
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
