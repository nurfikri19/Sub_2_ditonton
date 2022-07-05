import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/repositories/hptv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetHptvRecommendations {
  final HptvRepository repository;

  GetHptvRecommendations(this.repository);

  Future<Either<Failure, List<Hptv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
