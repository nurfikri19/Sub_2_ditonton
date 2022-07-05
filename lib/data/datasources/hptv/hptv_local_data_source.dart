import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper_hptv.dart';
import 'package:ditonton/data/models/hptv/hptv_table.dart';

abstract class HptvLocalDataSource {
  Future<String> insertWatchlistTv(HptvTable tv);
  Future<String> removeWatchlistTv(HptvTable tv);
  Future<HptvTable?> getTvById(int id);
  Future<List<HptvTable>> getWatchlistTv();
}

class HptvLocalDataSourceImpl implements HptvLocalDataSource {
  final DatabaseHelperHptv databaseHelperhptv;

  HptvLocalDataSourceImpl({required this.databaseHelperhptv});

  @override
  Future<String> insertWatchlistTv(HptvTable tv) async {
    try {
      await databaseHelperhptv.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(HptvTable tv) async {
    try {
      await databaseHelperhptv.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<HptvTable?> getTvById(int id) async {
    final result = await databaseHelperhptv.getTvById(id);
    if (result != null) {
      return HptvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<HptvTable>> getWatchlistTv() async {
    final result = await databaseHelperhptv.getWatchlistTv();
    return result.map((data) => HptvTable.fromMap(data)).toList();
  }
}
