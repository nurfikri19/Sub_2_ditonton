import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([MovieNowPlayingBloc,GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies
  mockGetNowPlayingMovies;
  late MovieNowPlayingBloc
  movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies
    = MockGetNowPlayingMovies();
    movieNowPlayingBloc
    = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
  });

  group('Now Playing Movies BLoC Test', () {
    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(movieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(MovieNowPlayingGetEvent()),
      expect: () => [MovieNowPlayingLoading(), MovieNowPlayingLoaded(movieList)],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [Loading, Error] when get now playing is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(MovieNowPlayingGetEvent()),
      expect: () => [
        MovieNowPlayingLoading(),
        const MovieNowPlayingError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
    },
  );
}