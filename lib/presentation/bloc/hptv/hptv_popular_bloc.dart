import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_popular_hptv.dart';
import 'package:equatable/equatable.dart';

part 'hptv_popular_event.dart';
part 'hptv_popular_state.dart';

class HptvPopularBloc extends Bloc<HptvPopularEvent, HptvPopularState> {
  final GetPopularHptv getPopularHptv;

  HptvPopularBloc(
      this.getPopularHptv,
      ) : super(HptvPopularEmpty()) {
    on<HptvPopularGetEvent>((event, emit) async {
      emit(HptvPopularLoading());
      final result = await getPopularHptv.execute();
      result.fold(
            (failure) {
          emit(HptvPopularError(failure.message));
        },
            (data) {
          emit(HptvPopularLoaded(data));
        },
      );
    });
  }
}