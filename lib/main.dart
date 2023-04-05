import 'package:beer_afternoon/app.dart';
import 'package:beer_repository/beer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    Bloc.observer = const AppBlocObserver();
  }
  runApp(BeerAfternoonApp(beerRepository: BeerRepository()));
}
