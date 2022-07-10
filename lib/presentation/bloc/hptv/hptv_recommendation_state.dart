part of 'hptv_recommendation_bloc.dart';

abstract
class HptvRecommendationState
    extends Equatable {
  const HptvRecommendationState();

  @override
  List<Object> get props
  => [];
}

class HptvRecommendationEmpty
    extends HptvRecommendationState {}

class HptvRecommendationLoading
    extends HptvRecommendationState {}

class HptvRecommendationError
    extends HptvRecommendationState {
  final String
  message;

  const
  HptvRecommendationError(this.message);

  @override
  List<Object> get props
  => [message];
}

class HptvRecommendationLoaded
    extends HptvRecommendationState {
  final List<Hptv>
  tv;

  const
  HptvRecommendationLoaded(this.tv);

  @override
  List<Object> get props
  => [tv];
}