import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/repositories/hptv_repository.dart';

class SearchHptv {
  final HptvRepository repository;

  SearchHptv(this.repository);

  Future<Either<Failure, List<Hptv>>> execute(String query) {
    return repository.searchTv(query);
  }
}
