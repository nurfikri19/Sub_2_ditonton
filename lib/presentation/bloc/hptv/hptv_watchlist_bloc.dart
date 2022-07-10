import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/entities/hptv/hptv_detail.dart';
import 'package:ditonton/domain/usecases/hptv/get_watchlist_status_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_watchlist_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/remove_watchlist_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/save_watchlist_hptv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hptv_watchlist_event.dart';
part 'hptv_watchlist_state.dart';

class HptvWatchlistBloc
    extends
    Bloc<HptvWatchlistEvent,
        HptvWatchlistState> {
  static
  const watchlistAddSuccessMessage
  = 'Added to Watchlist';
  static
  const watchlistRemoveSuccessMessage
  = 'Removed from Watchlist';

  final GetWatchlistHptv
  getWatchlistHptv;
  final GetWatchListStatusHptv
  getWatchListStatus;
  final SaveWatchlistHptv
  saveWatchlist;
  final RemoveWatchlistHptv
  removeWatchlist;

  HptvWatchlistBloc({
    required this.
    getWatchlistHptv,
    required this.
    getWatchListStatus,
    required this.
    saveWatchlist,
    required this.
    removeWatchlist,
  }) : super(HptvWatchlistEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(HptvWatchlistLoading());
      final result
      = await getWatchlistHptv.execute();
      result.fold(
        (failure) {
          emit(HptvWatchlistError(failure.message));
        },
        (data) {
          emit(HptvWatchlistLoaded(data));
        },
      );
    });

    on<GetStatusTvEvent>((event, emit) async {
      final id
      = event.id;
      final result
      = await getWatchListStatus.execute(id);

      emit(HptvWatchlistStatusLoaded(result));
    });

    on<AddItemTvEvent>((event, emit) async {
      final hptvDetail
      = event.hptvDetail;
      final result
      = await saveWatchlist.execute(hptvDetail);

      result.fold(
        (failure) {
          emit(HptvWatchlistError(failure.message));
        },
        (successMessage) {
          emit(HptvWatchlistSuccess(successMessage));
        },
      );
    });

    on<RemoveItemHptvEvent>((event, emit) async {
      final hptvDetail
      = event.hptvDetail;
      final result
      = await removeWatchlist.execute(hptvDetail);

      result.fold(
        (failure) {
          emit(HptvWatchlistError(failure.message));
        },
        (successMessage) {
          emit(HptvWatchlistSuccess(successMessage));
        },
      );
    });
  }
}