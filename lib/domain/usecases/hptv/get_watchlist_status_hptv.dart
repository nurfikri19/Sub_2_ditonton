import 'package:ditonton/domain/repositories/hptv_repository.dart';

class GetWatchListStatusHptv {
  final HptvRepository repository;

  GetWatchListStatusHptv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTv(id);
  }
}
