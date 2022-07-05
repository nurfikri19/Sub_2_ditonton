import 'package:ditonton/domain/usecases/hptv/get_watchlist_status_hptv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper_hptv.mocks.dart';

void main() {
  late GetWatchListStatusHptv usecase;
  late MockHptvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockHptvRepository();
    usecase = GetWatchListStatusHptv(mockTvRepository);
  });

  test('should get watchlist tv status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlistTv(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
