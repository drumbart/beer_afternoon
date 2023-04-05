import 'dart:async';

import 'package:beer_repository/beer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'beer_event.dart';

part 'beer_state.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  final BeerRepository _beerRepository;

  BeerBloc(this._beerRepository) : super(const BeerState()) {
    on<FetchBeer>(_onBeerFetch);
  }

  Future<void> _onBeerFetch(FetchBeer event, Emitter<BeerState> emit) async {
    emit(state.copyWith(status: BeerStatus.fetching));
    try {
      final beer = await _beerRepository.getBeer();
      return emit(state.copyWith(status: BeerStatus.success, beer: beer));
    } catch (_) {
      emit(state.copyWith(status: BeerStatus.failure));
    }
  }
}
