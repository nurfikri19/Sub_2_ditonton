import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/hptv/hptv_detail.dart';
import 'package:ditonton/domain/repositories/hptv_repository.dart';

class RemoveWatchlistHptv {
  final HptvRepository repository;

  RemoveWatchlistHptv(this.repository);

  Future<Either<Failure, String>> execute(HptvDetail tv) {
    return repository.removeWatchlistTv(tv);
  }
}
