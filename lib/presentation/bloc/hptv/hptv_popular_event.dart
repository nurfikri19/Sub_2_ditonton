part of 'hptv_popular_bloc.dart';

abstract class HptvPopularEvent
    extends Equatable {
  const HptvPopularEvent();

  @override
  List<Object> get props => [];
}

class HptvPopularGetEvent
    extends HptvPopularEvent {}