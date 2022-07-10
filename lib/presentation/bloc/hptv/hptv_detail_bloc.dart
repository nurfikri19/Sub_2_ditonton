import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/hptv/hptv_detail.dart';
import 'package:ditonton/domain/usecases/hptv/get_hptv_detail.dart';
import 'package:equatable/equatable.dart';

part 'hptv_detail_event.dart';
part 'hptv_detail_state.dart';

class HptvDetailBloc
    extends Bloc<HptvDetailEvent, HptvDetailState> {
  final GetHptvDetail
  getHptvDetail;

  HptvDetailBloc({
    required this.getHptvDetail,
  }) : super(HptvDetailEmpty()) {
    on<GetHptvDetailEvent>((event, emit) async {
      emit(HptvDetailLoading());
      final result
      = await getHptvDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(HptvDetailError(failure.message));
        },
        (data) {
          emit(HptvDetailLoaded(data));
        },
      );
    });
  }
}