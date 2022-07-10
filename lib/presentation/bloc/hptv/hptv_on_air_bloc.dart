import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_now_playing_hptv.dart';
import 'package:equatable/equatable.dart';

part 'hptv_on_air_event.dart';
part 'hptv_on_air_state.dart';

class HptvOnAirBloc
    extends Bloc<HptvOnAirEvent, HptvOnAirState> {
  final GetNowPlayingHptv
  getOnAirHptv;

  HptvOnAirBloc(
      this.getOnAirHptv,
      ) : super(HptvOnAirEmpty()) {
    on<HptvOnAirGetEvent>((event, emit) async {
      emit(HptvOnAirLoading());
      final result
      = await getOnAirHptv.execute();
      result.fold(
            (failure) {
          emit(HptvOnAirError(failure.message));
        },
            (data) {
          emit(HptvOnAirLoaded(data));
        },
      );
    });
  }
}