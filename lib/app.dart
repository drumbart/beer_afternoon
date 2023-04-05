import 'package:beer_afternoon/beer/bloc/beer_bloc.dart';
import 'package:beer_afternoon/beer/pages/beer_page.dart';
import 'package:beer_repository/beer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BeerAfternoonApp extends StatelessWidget {
  final BeerRepository _beerRepository;

  const BeerAfternoonApp({super.key, required BeerRepository beerRepository}) : _beerRepository = beerRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _beerRepository,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          appBarTheme: const AppBarTheme(color: Colors.white),
          scaffoldBackgroundColor: Colors.orangeAccent,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
        ),
        home: BlocProvider(
          create: (_) => BeerBloc(_beerRepository),
          child: const BeerPage(),
        ),
      ),
    );
  }
}
