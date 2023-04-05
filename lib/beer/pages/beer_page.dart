import 'package:beer_afternoon/beer/bloc/beer_bloc.dart';
import 'package:beer_afternoon/beer/widgets/widgets.dart';
import 'package:beer_afternoon/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeerPage extends StatelessWidget {
  const BeerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.strings.beerAfternoon,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const Spacer(),
              BlocBuilder<BeerBloc, BeerState>(
                builder: (context, state) {
                  switch (state.status) {
                    case BeerStatus.initial:
                      return BeerButtonWidget(
                        title: context.strings.grabMeAColdOne,
                        onPressed: () => context.read<BeerBloc>().add(FetchBeer()),
                      );
                    case BeerStatus.fetching:
                      return const CircularProgressIndicator();
                    case BeerStatus.success:
                      return BeerFetchedWidget(beer: state.beer);
                    case BeerStatus.failure:
                      return const BeerErrorWidget();
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
