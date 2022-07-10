import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_on_air_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../presentation/test_bloc/hptv.mocks.dart';


void main() {
  late MockGetNowPlayingHptv
  mockGetNowPlayingHptv;
  late HptvOnAirBloc
  hptvOnAirBloc;

  setUp(() {
    mockGetNowPlayingHptv
    = MockGetNowPlayingHptv();
    hptvOnAirBloc
    = HptvOnAirBloc(mockGetNowPlayingHptv);
  });

  final tvList = <Hptv>[];

  test("initial state should be empty", () {
    expect(hptvOnAirBloc.state, HptvOnAirEmpty());
  });

  group('On Air Tv BLoC Test', () {
    blocTest<HptvOnAirBloc, HptvOnAirState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingHptv.execute())
            .thenAnswer((_) async => Right(tvList));
        return hptvOnAirBloc;
      },
      act: (bloc)
      => bloc.add(HptvOnAirGetEvent()),
      expect: ()
      => [HptvOnAirLoading(), HptvOnAirLoaded(tvList)],
      verify: (bloc) {
        verify(mockGetNowPlayingHptv.execute());
      },
    );

    blocTest<HptvOnAirBloc, HptvOnAirState>(
      'Should emit [Loading, Error] when get now playing is unsuccessful',
      build: () {
        when(mockGetNowPlayingHptv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return hptvOnAirBloc;
      },
      act: (bloc)
      => bloc.add(HptvOnAirGetEvent()),
      expect: () => [
        HptvOnAirLoading(),
        const HptvOnAirError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingHptv.execute());
      },
    );
    },
  );
}