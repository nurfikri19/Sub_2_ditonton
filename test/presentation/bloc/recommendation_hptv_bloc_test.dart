import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_hptv_recomendations.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_hptv_bloc_test.mocks.dart';

@GenerateMocks([HptvRecommendationBloc,GetHptvRecommendations])
void main() {
  late MockGetHptvRecommendations mockGetHptvRecommendation;
  late HptvRecommendationBloc hptvRecommendationBloc;

  setUp(() {
    mockGetHptvRecommendation = MockGetHptvRecommendations();
    hptvRecommendationBloc = HptvRecommendationBloc(
      getHptvRecommendations: mockGetHptvRecommendation,
    );
  });

  test("initial state should be empty", () {
    expect(hptvRecommendationBloc.state, HptvRecommendationEmpty());
  });

  const tvId = 1;
  final tvList = <Hptv>[];

  blocTest<HptvRecommendationBloc, HptvRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetHptvRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(tvList));
      return hptvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetHptvRecommendationEvent(tvId)),
    expect: () =>
        [HptvRecommendationLoading(), HptvRecommendationLoaded(tvList)],
    verify: (bloc) {
      verify(mockGetHptvRecommendation.execute(tvId));
    },
  );

  group('Recommendation Tv BLoC Test', () {
    blocTest<HptvRecommendationBloc, HptvRecommendationState>(
      'Should emit [Loading, Error] when get recommendation is unsuccessful',
      build: () {
        when(mockGetHptvRecommendation.execute(tvId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return hptvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const GetHptvRecommendationEvent(tvId)),
      expect: () => [
        HptvRecommendationLoading(),
        const HptvRecommendationError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetHptvRecommendation.execute(tvId));
      },
    );
    },
  );
}