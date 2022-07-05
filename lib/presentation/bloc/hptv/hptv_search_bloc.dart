import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/usecases/hptv/search_hptv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hptv_search_event.dart';
part 'hptv_search_state.dart';

class HptvSearchBloc
    extends Bloc<HptvSearchEvent, HptvSearchState> {
  final SearchHptv searchHptv;

  HptvSearchBloc({
    required this.searchHptv,
  }) : super(HptvSearchEmpty()) {
    on<HptvSearchSetEmpty>((event, emit) => emit(HptvSearchEmpty()));

    on<HptvSearchQueryEvent>((event, emit) async {
      emit(HptvSearchLoading());
      final result = await searchHptv.execute(event.query);
      result.fold(
            (failure) {
          emit(HptvSearchError(failure.message));
        },
            (data) {
          emit(HptvSearchLoaded(data));
        },
      );
    });
  }
}