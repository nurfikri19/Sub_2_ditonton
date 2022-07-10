import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_hptv_recomendations.dart';
import 'package:equatable/equatable.dart';

part 'hptv_recommendation_event.dart';
part 'hptv_recommendation_state.dart';

class HptvRecommendationBloc
    extends
    Bloc<HptvRecommendationEvent,
        HptvRecommendationState> {
  final GetHptvRecommendations
  getHptvRecommendations;

  HptvRecommendationBloc({
    required this.getHptvRecommendations,
  }) : super(HptvRecommendationEmpty()) {
     on<GetHptvRecommendationEvent>((event, emit) async {
      emit(HptvRecommendationLoading());
      final result
      = await getHptvRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(HptvRecommendationError(failure.message));
        },
        (data) {
          emit(HptvRecommendationLoaded(data));
        },
      );
    });
  }
}