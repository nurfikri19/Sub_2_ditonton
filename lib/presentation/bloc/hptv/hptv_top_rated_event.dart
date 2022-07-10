part of 'hptv_top_rated_bloc.dart';

abstract
class HptvTopRatedEvent
    extends Equatable {
  const HptvTopRatedEvent();

  @override
  List<Object> get props
  => [];
}

class HptvTopRatedGetEvent
    extends HptvTopRatedEvent {}