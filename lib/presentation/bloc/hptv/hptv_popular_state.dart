part of 'hptv_popular_bloc.dart';

abstract
class HptvPopularState
    extends Equatable {
  const HptvPopularState();

  @override
  List<Object> get props
  => [];
}

class HptvPopularEmpty
    extends HptvPopularState {}

class HptvPopularLoading
    extends HptvPopularState {}

class HptvPopularError
    extends HptvPopularState {
  final String message;

  const
  HptvPopularError(this.message);

  @override
  List<Object> get props
  => [message];
}

class HptvPopularLoaded
    extends HptvPopularState {
  final List<Hptv>
  result;

  const
  HptvPopularLoaded(this.result);

  @override
  List<Object> get props
  => [result];
}