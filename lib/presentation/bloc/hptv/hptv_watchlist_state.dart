part of 'hptv_watchlist_bloc.dart';

abstract
class HptvWatchlistState
    extends Equatable {
  const HptvWatchlistState();

  @override
  List<Object> get props
  => [];
}

class HptvWatchlistEmpty
    extends HptvWatchlistState {}

class HptvWatchlistLoading
    extends HptvWatchlistState {}

class HptvWatchlistError
    extends HptvWatchlistState {
  final String
  message;

  const
  HptvWatchlistError(this.message);

  @override
  List<Object> get props
  => [message];
}

class HptvWatchlistSuccess
    extends HptvWatchlistState {
  final String
  message;

  const
  HptvWatchlistSuccess(this.message);

  @override
  List<Object> get props
  => [message];
}

class HptvWatchlistLoaded
    extends HptvWatchlistState {
  final List<Hptv>
  result;

  const
  HptvWatchlistLoaded(this.result);

  @override
  List<Object> get props
  => [result];
}

class HptvWatchlistStatusLoaded
    extends HptvWatchlistState {
  final bool
  result;

  const
  HptvWatchlistStatusLoaded(this.result);

  @override
  List<Object> get props
  => [result];
}