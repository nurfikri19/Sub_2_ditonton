import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../presentation/test_bloc/movie.mocks.dart';

void main() {
  late MockGetWatchlistMovies
  mockGetWatchlistMovies;
  late MockGetWatchListStatus
  mockGetWatchListStatus;
  late MockSaveWatchlist
  mockSaveWatchlist;
  late MockRemoveWatchlist
  mockRemoveWatchlist;
  late MovieWatchlistBloc
  movieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies
    = MockGetWatchlistMovies();
    mockGetWatchListStatus
    = MockGetWatchListStatus();
    mockSaveWatchlist
    = MockSaveWatchlist();
    mockRemoveWatchlist
    = MockRemoveWatchlist();
    movieWatchlistBloc
    = MovieWatchlistBloc(
      getWatchlistMovies
          : mockGetWatchlistMovies,
      getWatchListStatus
          : mockGetWatchListStatus,
      saveWatchlist
          : mockSaveWatchlist,
      removeWatchlist
          : mockRemoveWatchlist,
    );
  });

  const
  movieId = 1;

  test("initial state should be empty", () {
    expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testWatchlistMovieList));
      return
        movieWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(GetListEvent()),
    expect: () =>
        [MovieWatchlistLoading(), MovieWatchlistLoaded(testWatchlistMovieList)],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("Can't get data")));
      return
        movieWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(GetListEvent()),
    expect: () =>
        [MovieWatchlistLoading(), const MovieWatchlistError("Can't get data")],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loaded] when get status movie watchlist is successful',
    build: () {
      when(mockGetWatchListStatus.execute(movieId))
          .thenAnswer((_) async => true);
      return
        movieWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(const GetStatusMovieEvent(movieId)),
    expect: ()
    => [const MovieWatchlistStatusLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(movieId));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [success] when add movie item to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Success"));
      return
        movieWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(AddItemMovieEvent(testMovieDetail)),
    expect: ()
    => [const MovieWatchlistSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [success] when remove movie item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Removed"));
      return
        movieWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(RemoveItemMovieEvent(testMovieDetail)),
    expect: ()
    => [const MovieWatchlistSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [error] when add movie item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return
        movieWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(AddItemMovieEvent(testMovieDetail)),
    expect: ()
    => [const MovieWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [error] when remove movie item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return
        movieWatchlistBloc;
    },
    act: (bloc)
    => bloc.add(RemoveItemMovieEvent(testMovieDetail)),
    expect: ()
    => [const MovieWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}