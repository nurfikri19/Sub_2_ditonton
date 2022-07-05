import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_hptv_recomendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper_hptv.mocks.dart';

void main() {
  late GetHptvRecommendations usecase;
  late MockHptvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockHptvRepository();
    usecase = GetHptvRecommendations(mockTvRepository);
  });

  final tId = 1;
  final tTv = <Hptv>[];

  test('should get list of tv recommendations from the repository',
          () async {
        // arrange
        when(mockTvRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTv));
      });
}
