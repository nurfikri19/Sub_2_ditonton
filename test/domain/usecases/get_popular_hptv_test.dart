import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_popular_hptv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper_hptv.mocks.dart';

void main() {
  late GetPopularHptv usecase;
  late MockHptvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockHptvRepository();
    usecase = GetPopularHptv(mockTvRpository);
  });

  final tTv = <Hptv>[];

  group('Get Popular Tv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
              () async {
            // arrange
            when(mockTvRpository.getPopularTv())
                .thenAnswer((_) async => Right(tTv));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTv));
          });
    });
  });
}
