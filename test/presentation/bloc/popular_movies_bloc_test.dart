import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../presentation/test_bloc/movie.mocks.dart';

void main() {
  late MockGetPopularMovies
  mockGetPopularMovies;
  late MoviePopularBloc
  moviePopularBloc;

  setUp(() {
    mockGetPopularMovies
    = MockGetPopularMovies();
    moviePopularBloc
    = MoviePopularBloc(mockGetPopularMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(moviePopularBloc.state, MoviePopularEmpty());
  });

  group('Popular Movies BLoC Test', () {
    blocTest<MoviePopularBloc, MoviePopularState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(movieList));
          return moviePopularBloc;
        },
        act: (bloc)
        => bloc.add(MoviePopularGetEvent()),
        expect: () =>
            [MoviePopularLoading(), MoviePopularLoaded(movieList)],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });

    blocTest<MoviePopularBloc, MoviePopularState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(MoviePopularGetEvent()),
        expect: () =>
            [MoviePopularLoading(), MoviePopularError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });
}
