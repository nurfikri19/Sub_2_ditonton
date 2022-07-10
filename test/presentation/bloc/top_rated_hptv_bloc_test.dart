import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_top_rated_bloc.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../presentation/test_bloc/hptv.mocks.dart';

void main() {
  late MockGetTopRatedHptv
  mockGetTopRatedHptv;
  late HptvTopRatedBloc
  hptvTopRatedBloc;

  setUp(() {
    mockGetTopRatedHptv 
    = MockGetTopRatedHptv();
    hptvTopRatedBloc 
    = HptvTopRatedBloc(mockGetTopRatedHptv);
  });

  final tvList = <Hptv>[];

  test("initial state should be empty", () {
      expect(hptvTopRatedBloc.state, HptvTopRatedEmpty());
    });

  group('Top Rated Movies BLoC Test', () {
    blocTest<HptvTopRatedBloc, HptvTopRatedState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedHptv.execute())
            .thenAnswer((_) async => Right(tvList));
        return hptvTopRatedBloc;
      },
      act: (bloc)
      => bloc.add(HptvTopRatedGetEvent()),
      expect: ()
      => [HptvTopRatedLoading(), HptvTopRatedLoaded(tvList)],
      verify: (bloc) {
        verify(mockGetTopRatedHptv.execute());
      },
    );

    blocTest<HptvTopRatedBloc, HptvTopRatedState>(
      'Should emit [Loading, Error] when get top rated is unsuccessful',
      build: () {
        when(mockGetTopRatedHptv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return hptvTopRatedBloc;
      },
      act: (bloc)
      => bloc.add(HptvTopRatedGetEvent()),
      expect: () =>
          [HptvTopRatedLoading(), const HptvTopRatedError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTopRatedHptv.execute());
      },
    );
  },);
}