import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_top_rated_hptv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper_hptv.mocks.dart';

void main() {
  late GetTopRatedHptv usecase;
  late MockHptvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockHptvRepository();
    usecase = GetTopRatedHptv(mockTvRepository);
  });

  final tTv = <Hptv>[];

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}
