import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/hptv/remove_watchlist_hptv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_hptv.dart';
import '../../helpers/test_helper_hptv.mocks.dart';

void main() {
  late RemoveWatchlistHptv usecase;
  late MockHptvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockHptvRepository();
    usecase = RemoveWatchlistHptv(mockTvRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlistTv(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeWatchlistTv(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
