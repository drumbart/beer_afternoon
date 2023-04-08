part of 'beer_bloc.dart';

abstract class BeerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBeer extends BeerEvent {}
