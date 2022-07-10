part of 'hptv_search_bloc.dart';

abstract
class HptvSearchState
    extends Equatable {
  const HptvSearchState();

  @override
  List<Object> get props
  => [];
}

class HptvSearchEmpty
    extends HptvSearchState {}

class HptvSearchLoading
    extends HptvSearchState {}

class HptvSearchError
    extends HptvSearchState {
  final String
  message;

  const
  HptvSearchError(this.message);

  @override
  List<Object>
  get props
  => [message];
}

class HptvSearchLoaded
    extends HptvSearchState {
  final
  List<Hptv>
  result;

  const
  HptvSearchLoaded(this.result);

  @override
  List<Object> get props
  => [result];
}