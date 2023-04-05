import 'package:beer_afternoon/beer/bloc/beer_bloc.dart';
import 'package:beer_afternoon/beer/widgets/beer_button_widget.dart';
import 'package:beer_afternoon/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeerErrorWidget extends StatelessWidget {
  const BeerErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.strings.errorFetchingBeer,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 30),
        BeerButtonWidget(
          onPressed: () => context.read<BeerBloc>().add(FetchBeer()),
          title: context.strings.tryAgain,
        ),
      ],
    );
  }
}
