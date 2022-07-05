import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/entities/hptv/hptv_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class HptvRepository {
  Future<Either<Failure, List<Hptv>>> getNowPlayingTv();
  Future<Either<Failure, List<Hptv>>> getPopularTv();
  Future<Either<Failure, List<Hptv>>> getTopRatedTv();
  Future<Either<Failure, HptvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Hptv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Hptv>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlistTv(HptvDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(HptvDetail tv);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<Hptv>>> getWatchlistTv();
}
