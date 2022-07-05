import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/hptv/save_watchlist_hptv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_hptv.dart';
import '../../helpers/test_helper_hptv.mocks.dart';

void main() {
  late SaveWatchlistHptv usecase;
  late MockHptvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockHptvRepository();
    usecase = SaveWatchlistHptv(mockTvRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlistTv(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.saveWatchlistTv(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
