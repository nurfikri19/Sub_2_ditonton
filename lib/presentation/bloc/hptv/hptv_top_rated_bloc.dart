import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_top_rated_hptv.dart';
import 'package:equatable/equatable.dart';

part 'hptv_top_rated_event.dart';
part 'hptv_top_rated_state.dart';

class HptvTopRatedBloc
    extends Bloc<HptvTopRatedEvent, HptvTopRatedState> {
  final GetTopRatedHptv getTopRatedHptv;

  HptvTopRatedBloc(
    this.getTopRatedHptv,
  ) : super(HptvTopRatedEmpty()) {
    on<HptvTopRatedGetEvent>((event, emit) async {
      emit(HptvTopRatedLoading());
      final result = await getTopRatedHptv.execute();
      result.fold(
        (failure) {
          emit(HptvTopRatedError(failure.message));
        },
        (data) {
          emit(HptvTopRatedLoaded(data));
        },
      );
    });
  }
}