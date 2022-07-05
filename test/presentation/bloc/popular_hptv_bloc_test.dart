import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/hptv/get_popular_hptv.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_popular_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'popular_hptv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularHptv, HptvPopularBloc])
void main() {
  late MockGetPopularHptv mockGetPopularHptv;
  late HptvPopularBloc hptvPopularBloc;

  setUp(() {
    mockGetPopularHptv = MockGetPopularHptv();
    hptvPopularBloc = HptvPopularBloc(mockGetPopularHptv);
  });

  final TvList = <Hptv>[];

  test("initial state should be empty", () {
    expect(hptvPopularBloc.state, HptvPopularEmpty());
  });

  group('Popular Tv BLoC Test', () {
    blocTest<HptvPopularBloc, HptvPopularState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularHptv.execute()).thenAnswer((_) async => Right(TvList));
        return hptvPopularBloc;
      },
      act: (bloc) => bloc.add(HptvPopularGetEvent()),
      expect: () => [HptvPopularLoading(), HptvPopularLoaded(TvList)],
      verify: (bloc) {
        verify(mockGetPopularHptv.execute());
      },
    );

    blocTest<HptvPopularBloc, HptvPopularState>(
      'Should emit [Loading, Error] when get popular is unsuccessful',
      build: () {
        when(mockGetPopularHptv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return hptvPopularBloc;
      },
      act: (bloc) => bloc.add(HptvPopularGetEvent()),
      expect: () => [HptvPopularLoading(),  HptvPopularError('Server Failure')],
      verify: (bloc) {
        verify(mockGetPopularHptv.execute());
      },
    );
  },);
}