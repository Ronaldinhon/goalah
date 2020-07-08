import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'pkwc.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE country(id INTEGER PRIMARY KEY, country_code TEXT)');
    }, version: 1);
  }

  static Future<void> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table, int id) async {
    final db = await DBHelper.database();
    return db.query(table, columns: ['country_code'], where: '"id" = ?', whereArgs: [id.toString()]);
  }

  static Future<sql.Database> databaseAchieve() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'achievementwc.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE achieve(id TEXT PRIMARY KEY, high_score INTEGER, worldcup INTEGER, sent_worldcup INTEGER)');
    }, version: 1);
  }

  static Future<void> insertAchieve(
    String table,
    Map<String, dynamic> data,
  ) async {
    final db = await DBHelper.databaseAchieve();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getAllAchieve() async {
    final db = await DBHelper.databaseAchieve();
    return db.query('achieve');
  }

  static Future<List<Map<String, dynamic>>> getAchieve(String id) async {
    final db = await DBHelper.databaseAchieve();
    return db.query('achieve', columns: ['high_score', 'worldcup'], where: '"id" = ?', whereArgs: [id]);
  }
} 