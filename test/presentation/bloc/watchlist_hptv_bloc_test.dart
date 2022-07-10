import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_hptv.dart';
import '../../presentation/test_bloc/hptv.mocks.dart';


void main() {
  late MockGetWatchlistHptv 
  mockGetWatchlistHptv;
  late MockGetWatchListStatusHptv 
  mockGetWatchListStatus;
  late MockSaveWatchlistHptv 
  mockSaveWatchlist;
  late MockRemoveWatchlistHptv 
  mockRemoveWatchlist;
  late HptvWatchlistBloc 
  hptvWatchlistBloc;

  setUp(() {
    mockGetWatchlistHptv 
    = MockGetWatchlistHptv();
    mockGetWatchListStatus 
    = MockGetWatchListStatusHptv();
    mockSaveWatchlist 
    = MockSaveWatchlistHptv();
    mockRemoveWatchlist 
    = MockRemoveWatchlistHptv();
    hptvWatchlistBloc 
    = HptvWatchlistBloc(
      getWatchlistHptv
          : mockGetWatchlistHptv,
      getWatchListStatus
          : mockGetWatchListStatus,
      saveWatchlist
          : mockSaveWatchlist,
      removeWatchlist
          : mockRemoveWatchlist,
    );
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(hptvWatchlistBloc.state, HptvWatchlistEmpty());
  });

  blocTest<HptvWatchlistBloc, HptvWatchlistState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistHptv.execute())
          .thenAnswer((_) async => Right(testWatchlistHptvList));
      return hptvWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(GetListEvent()),
    expect: () =>
        [HptvWatchlistLoading(), HptvWatchlistLoaded(testWatchlistHptvList)],
    verify: (bloc) {
      verify(mockGetWatchlistHptv.execute());
    },
  );

  blocTest<HptvWatchlistBloc, HptvWatchlistState>(
    'Should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistHptv.execute())
          .thenAnswer((_) async => Left(ServerFailure("Can't get data")));
      return hptvWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(GetListEvent()),
    expect: () =>
        [HptvWatchlistLoading(), const HptvWatchlistError("Can't get data")],
    verify: (bloc) {
      verify(mockGetWatchlistHptv.execute());
    },
  );

  blocTest<HptvWatchlistBloc, HptvWatchlistState>(
    'Should emit [Loaded] when get status tv watchlist is successful',
    build: () {
      when(mockGetWatchListStatus.execute(tvId))
          .thenAnswer((_) async => true);
      return hptvWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(const GetStatusTvEvent(tvId)),
    expect: ()
    => [const HptvWatchlistStatusLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tvId));
    },
  );

  blocTest<HptvWatchlistBloc, HptvWatchlistState>(
    'Should emit [success] when add tv item to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Success"));
      return hptvWatchlistBloc;
    },

    act: (bloc)
    => bloc.add(AddItemTvEvent(testTvDetail)),
    expect: ()
    => [const HptvWatchlistSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<HptvWatchlistBloc, HptvWatchlistState>(
    'Should emit [success] when remove tv item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Removed"));
      return hptvWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(RemoveItemHptvEvent(testTvDetail)),
    expect: ()
    => [const HptvWatchlistSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<HptvWatchlistBloc, HptvWatchlistState>(
    'Should emit [error] when add tv item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return hptvWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(AddItemTvEvent(testTvDetail)),
    expect: ()
    => [const HptvWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<HptvWatchlistBloc, HptvWatchlistState>(
    'Should emit [error] when remove tv item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return hptvWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(RemoveItemHptvEvent(testTvDetail)),
    expect: ()
    => [const HptvWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );
}