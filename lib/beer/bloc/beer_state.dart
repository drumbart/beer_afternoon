part of 'beer_bloc.dart';

enum BeerStatus { initial, fetching, success, failure }

class BeerState extends Equatable {
  final BeerStatus status;
  final Beer beer;

  const BeerState({
    this.status = BeerStatus.initial,
    this.beer = Beer.empty,
  });

  BeerState copyWith({BeerStatus? status, Beer? beer}) => BeerState(status: status ?? this.status, beer: beer ?? this.beer);

  @override
  List<Object> get props => [status, beer];
}
