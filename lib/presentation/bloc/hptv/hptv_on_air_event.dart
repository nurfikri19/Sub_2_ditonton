part of 'hptv_on_air_bloc.dart';

abstract class
  HptvOnAirEvent
    extends Equatable {
  const HptvOnAirEvent();

  @override
  List<Object> get props => [];
}

class HptvOnAirGetEvent
    extends HptvOnAirEvent {}