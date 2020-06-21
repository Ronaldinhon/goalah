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
} 