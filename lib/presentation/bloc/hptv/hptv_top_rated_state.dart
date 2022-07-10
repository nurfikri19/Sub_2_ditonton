part of 'hptv_top_rated_bloc.dart';

abstract
class HptvTopRatedState
    extends Equatable {
  const HptvTopRatedState();

  @override
  List<Object> get props
  => [];
}

class HptvTopRatedEmpty
    extends HptvTopRatedState {}

class HptvTopRatedLoading
    extends HptvTopRatedState {}

class HptvTopRatedError
    extends HptvTopRatedState {
  final String
  message;

  const
  HptvTopRatedError(this.message);

  @override
  List<Object> get props
  => [message];
}

class HptvTopRatedLoaded
    extends HptvTopRatedState {
  final List<Hptv>
  result;

  const
  HptvTopRatedLoaded(this.result);

  @override
  List<Object> get props
  => [result];
}