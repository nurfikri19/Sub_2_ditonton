import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/repositories/hptv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistHptv {
  final HptvRepository _repository;

  GetWatchlistHptv(this._repository);

  Future<Either<Failure, List<Hptv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
