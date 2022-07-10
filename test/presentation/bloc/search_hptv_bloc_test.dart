import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../presentation/test_bloc/hptv.mocks.dart';


void main() {
  late MockSearchHptv
  mockSearchHptv;
  late HptvSearchBloc
  hptvSearchBloc;

  setUp(() {
    mockSearchHptv
    = MockSearchHptv();
    hptvSearchBloc
    = HptvSearchBloc(
      searchHptv
          : mockSearchHptv,
    );
  });

  const query 
  = "originalTitle";
  final 
  tvList = <Hptv>[];

  test("initial state should be empty", () {
    expect(hptvSearchBloc.state, HptvSearchEmpty());
  });

  blocTest<HptvSearchBloc, HptvSearchState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchHptv.execute(query))
          .thenAnswer((_) async => Right(tvList));
      return hptvSearchBloc;
    },
    act: (bloc)
    => bloc.add(const HptvSearchQueryEvent(query)),
    expect: ()
    => [HptvSearchLoading(), HptvSearchLoaded(tvList)],
    verify: (bloc) {
      verify(mockSearchHptv.execute(query));
    },
  );

  group('Search Tv BLoC Test', () {
    blocTest<HptvSearchBloc, HptvSearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchHptv.execute(query))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return hptvSearchBloc;
      },
      act: (bloc)
      => bloc.add(const HptvSearchQueryEvent(query)),
      expect: () =>
          [HptvSearchLoading(), const HptvSearchError('Server Failure')],
      verify: (bloc) {
        verify(mockSearchHptv.execute(query));
      },
    );
    },
  );
}