import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_hptv.dart';
import '../../presentation/test_bloc/hptv.mocks.dart';

void main() {
  late MockGetHptvDetail
  mockGetHptvDetail;
  late HptvDetailBloc
  hptvDetailBloc;
  setUp(() {
    mockGetHptvDetail
    = MockGetHptvDetail();
    hptvDetailBloc
    = HptvDetailBloc(getHptvDetail: mockGetHptvDetail);
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(hptvDetailBloc.state, HptvDetailEmpty());
  });

  group('Top Rated Movies BLoC Test', () {
    blocTest<HptvDetailBloc, HptvDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetHptvDetail.execute(tvId))
            .thenAnswer((_) async => Right(testTvDetail));
        return hptvDetailBloc;
      },
      act: (bloc)
      => bloc.add(const GetHptvDetailEvent(tvId)),
      expect: ()
      => [HptvDetailLoading(), HptvDetailLoaded(testTvDetail)],
      verify: (bloc) {
        verify(mockGetHptvDetail.execute(tvId));
      },
    );

    blocTest<HptvDetailBloc, HptvDetailState>(
      'Should emit [Loading, Error] when get detail is unsuccessful',
      build: () {
        when(mockGetHptvDetail.execute(tvId))
            .thenAnswer((_) async
        => Left(ServerFailure('Server Failure')));
        return hptvDetailBloc;
      },
      act: (bloc)
      => bloc.add(const GetHptvDetailEvent(tvId)),
      expect: ()
      => [HptvDetailLoading(),
        const HptvDetailError('Server Failure')],
      verify: (bloc) {
        verify(mockGetHptvDetail.execute(tvId));
      },
    );
  },);
}