import 'dart:async';

import 'package:ditonton/data/models/hptv/hptv_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperHptv {
  static DatabaseHelperHptv? _databaseHelperhptv;
  DatabaseHelperHptv._instance() {
    _databaseHelperhptv = this;
  }

  factory DatabaseHelperHptv() => _databaseHelperhptv ?? DatabaseHelperHptv._instance();

  static Database? _databasehptv;

  Future<Database?> get databasehptv async {
    if (_databasehptv == null) {
      _databasehptv = await _initDb();
    }
    return _databasehptv;
  }

  static const String _tblWatchlisthptv = 'watchlisttv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontontvs.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlisthptv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistTv(HptvTable tv) async {
    final db = await databasehptv;
    return await db!.insert(_tblWatchlisthptv, tv.toJson());
  }

  Future<int> removeWatchlistTv(HptvTable tv) async {
    final db = await databasehptv;
    return await db!.delete(
      _tblWatchlisthptv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await databasehptv;
    final results = await db!.query(
      _tblWatchlisthptv,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await databasehptv;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlisthptv);

    return results;
  }
}
