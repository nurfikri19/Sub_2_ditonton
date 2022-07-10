import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../presentation/test_bloc/movie.mocks.dart';

void main() {
  late MockGetMovieRecommendations
  mockGetMovieRecommendation;
  late MovieRecommendationBloc
  movieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendation
    = MockGetMovieRecommendations();
    movieRecommendationBloc
    = MovieRecommendationBloc(
      getMovieRecommendations
          : mockGetMovieRecommendation,
    );
  });

  test("initial state should be empty", () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
  });

  const
  movieId = 1;
  final
  movieList = <Movie>[];

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(movieId))
          .thenAnswer((_) async => Right(movieList));
      return movieRecommendationBloc;
    },
    act: (bloc)
    => bloc.add(const GetMovieRecommendationEvent(movieId)),
    expect: () =>
        [MovieRecommendationLoading(), MovieRecommendationLoaded(movieList)],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(movieId));
    },
  );

  group('Recommendation Movies BLoC Test', () {
    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'Should emit [Loading, Error] when get recommendation is unsuccessful',
      build: () {
        when(mockGetMovieRecommendation.execute(movieId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (bloc)
      => bloc.add(const GetMovieRecommendationEvent(movieId)),
      expect: () => [
        MovieRecommendationLoading(),
        const MovieRecommendationError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendation.execute(movieId));
      },
    );
    },
  );
}