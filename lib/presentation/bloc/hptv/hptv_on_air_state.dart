part of 'hptv_on_air_bloc.dart';

abstract class HptvOnAirState extends Equatable {
  const HptvOnAirState();

  @override
  List<Object> get props => [];
}

class HptvOnAirEmpty
    extends HptvOnAirState {}

class HptvOnAirLoading
    extends HptvOnAirState {}

class HptvOnAirError
    extends HptvOnAirState {
  final String message;

  const HptvOnAirError(this.message);

  @override
  List<Object> get props => [message];
}

class HptvOnAirLoaded
    extends HptvOnAirState {
  final List<Hptv> result;

  const HptvOnAirLoaded(this.result);

  @override
  List<Object> get props => [result];
}