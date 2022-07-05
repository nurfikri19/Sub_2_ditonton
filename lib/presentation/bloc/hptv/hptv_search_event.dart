part of 'hptv_search_bloc.dart';

abstract class HptvSearchEvent
    extends Equatable {
  const HptvSearchEvent();

  @override
  List<Object> get props => [];
}

class HptvSearchSetEmpty
    extends HptvSearchEvent {}

class HptvSearchQueryEvent
    extends HptvSearchEvent {
  final String query;

  const HptvSearchQueryEvent(this.query);

  @override
  List<Object> get props => [];
}