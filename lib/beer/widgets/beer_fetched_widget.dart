import 'package:beer_afternoon/beer/bloc/beer_bloc.dart';
import 'package:beer_afternoon/beer/pages/beer_details_page.dart';
import 'package:beer_afternoon/beer/widgets/beer_button_widget.dart';
import 'package:beer_afternoon/extensions/build_context.dart';
import 'package:beer_repository/beer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const beerDetailsButtonKey = 'beerDetailsButton';

class BeerFetchedWidget extends StatelessWidget {
  final Beer beer;

  const BeerFetchedWidget({super.key, required this.beer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${context.strings.iFoundSomethingForYou}:',
          style: const TextStyle(fontSize: 20, color: Colors.white70),
        ),
        const SizedBox(height: 30),
        _BeerInfoWidget(beer: beer),
        const SizedBox(height: 30),
        BeerButtonWidget(
          key: const Key(beerDetailsButtonKey),
          onPressed: () => Navigator.of(context).push<void>(
            BeerDetailsPage.route(beer),
          ),
          title: context.strings.details,
        ),
        const SizedBox(height: 50),
        BeerButtonWidget(
          onPressed: () => context.read<BeerBloc>().add(FetchBeer()),
          title: context.strings.iWantSomethingElse,
        ),
      ],
    );
  }
}

class _BeerInfoWidget extends StatelessWidget {
  final Beer beer;

  const _BeerInfoWidget({required this.beer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          beer.name,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          beer.brand,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
