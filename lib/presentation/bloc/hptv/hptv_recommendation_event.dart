part of 'hptv_recommendation_bloc.dart';

abstract class HptvRecommendationEvent
    extends Equatable {
  const HptvRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetHptvRecommendationEvent
    extends HptvRecommendationEvent {
  final int id;

  const GetHptvRecommendationEvent(this.id);

  @override
  List<Object> get props => [];
}