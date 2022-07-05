import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/hptv/hptv_detail.dart';
import 'package:ditonton/domain/repositories/hptv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetHptvDetail {
  final HptvRepository repository;

  GetHptvDetail(this.repository);

  Future<Either<Failure, HptvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
