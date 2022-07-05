part of 'hptv_watchlist_bloc.dart';

abstract class HptvWatchlistEvent
    extends Equatable {
  const HptvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class GetListEvent
    extends HptvWatchlistEvent {}

class GetStatusTvEvent
    extends HptvWatchlistEvent {
  final int id;

  const GetStatusTvEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddItemTvEvent
    extends HptvWatchlistEvent {
  final HptvDetail hptvDetail;

  const AddItemTvEvent(this.hptvDetail);

  @override
  List<Object> get props => [hptvDetail];
}

class RemoveItemHptvEvent
    extends HptvWatchlistEvent {
  final HptvDetail hptvDetail;

  const RemoveItemHptvEvent(this.hptvDetail);

  @override
  List<Object> get props => [hptvDetail];
}