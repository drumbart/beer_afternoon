import 'package:beer_afternoon/app.dart';
import 'package:beer_afternoon/beer/bloc/beer_bloc.dart';
import 'package:beer_afternoon/beer/pages/beer_details_page.dart';
import 'package:beer_afternoon/beer/pages/beer_page.dart';
import 'package:beer_afternoon/beer/widgets/widgets.dart';
import 'package:beer_repository/beer_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'utils/localizations_injection.dart';

class MockBeerRepository extends Mock implements BeerRepository {}

class MockBeerBloc extends MockBloc<BeerEvent, BeerState> implements BeerBloc {}

void main() {
  group('BeerAfternoonApp', () {
    const beer = Beer(
      id: 1,
      uid: "abc",
      brand: "Pabst Blue Ribbon",
      name: "Ten FIDY",
      style: "Belgian And French Ale",
      hop: "Simcoe",
      yeast: "1010 - American Wheat",
      malts: "Chocolate",
      ibu: "56 IBU",
      alcohol: "8.5%",
      blg: "6.7°Blg",
    );

    late BeerRepository beerRepository;
    late BeerBloc beerBloc;

    setUp(() {
      beerRepository = MockBeerRepository();
      beerBloc = MockBeerBloc();
    });

    testWidgets('render BeerPage', (WidgetTester tester) async {
      await tester.pumpWidget(BeerAfternoonApp(beerRepository: beerRepository));
      expect(find.byType(BeerPage), findsOneWidget);
    });

    testWidgets('render BeerButtonWidget for BeerStatus.initial', (WidgetTester tester) async {
      when(() => beerBloc.state).thenReturn(const BeerState());
      await tester.pumpWidget(
        BlocProvider.value(
          value: beerBloc,
          child: const LocalizationsInjection(
            child: BeerPage(),
          ),
        ),
      );
      expect(find.byType(BeerButtonWidget), findsOneWidget);
    });

    testWidgets('render CircularProgressIndicator for BeerStatus.fetching', (WidgetTester tester) async {
      when(() => beerBloc.state).thenReturn(const BeerState(status: BeerStatus.fetching));
      await tester.pumpWidget(
        BlocProvider.value(
          value: beerBloc,
          child: const LocalizationsInjection(
            child: BeerPage(),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('render BeerFetchedWidget for BeerStatus.success', (WidgetTester tester) async {
      when(() => beerBloc.state).thenReturn(const BeerState(status: BeerStatus.success, beer: beer));
      await tester.pumpWidget(
        BlocProvider.value(
          value: beerBloc,
          child: const LocalizationsInjection(
            child: BeerPage(),
          ),
        ),
      );
      expect(find.byType(BeerFetchedWidget), findsOneWidget);
    });

    testWidgets('render BeerErrorWidget for BeerStatus.failure', (WidgetTester tester) async {
      when(() => beerBloc.state).thenReturn(const BeerState(status: BeerStatus.failure));
      await tester.pumpWidget(
        BlocProvider.value(
          value: beerBloc,
          child: const LocalizationsInjection(
            child: BeerPage(),
          ),
        ),
      );
      expect(find.byType(BeerErrorWidget), findsOneWidget);
    });

    testWidgets('show BeerDetailsPage on details button tap', (WidgetTester tester) async {
      when(() => beerBloc.state).thenReturn(const BeerState(status: BeerStatus.success, beer: beer));
      await tester.pumpWidget(
        BlocProvider.value(
          value: beerBloc,
          child: const LocalizationsInjection(
            child: BeerPage(),
          ),
        ),
      );
      await tester.tap(find.byKey(const Key(beerDetailsButtonKey)));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(BeerDetailsPage), findsOneWidget);
    });
  });
}
