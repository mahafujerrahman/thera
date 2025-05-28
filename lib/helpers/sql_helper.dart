import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'logger_helper.dart';

class DatabaseHelper {
  static Database? _database;
  final String dbName;

  DatabaseHelper({required this.dbName});

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // do not create table here
  }

  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    final db = await database;

    // check if the table is exists
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );

    if (tables.isEmpty) {
      // create table if not exists
      await _createTable(db, tableName, data);
    }
    LoggerHelper.info(
      "==========>>DATA INSERTED TO THE TABLE $tableName <<==========",
    );
    // insert data
    return await db.insert(tableName, data);
  }

  Future<void> _createTable(
    Database db,
    String tableName,
    Map<String, dynamic> data,
  ) async {
    // create column
    List<String> columns = [
      'id INTEGER PRIMARY KEY AUTOINCREMENT'
    ]; // Always add an ID column
    data.forEach((key, value) {
      if (key != 'id') {
        // Skip 'id' if it's already in the data
        if (value is int) {
          columns.add('$key INTEGER');
        } else if (value is String) {
          columns.add('$key TEXT');
        } else if (value is double) {
          columns.add('$key REAL');
        }
      }
    });

    //create table
    final query = 'CREATE TABLE $tableName (${columns.join(', ')})';
    await db.execute(query);
    LoggerHelper.info(
      "==========>>Table -->$tableName<-- CREATED!<<==========",
    );
  }

  Future<int> update(
    String tableName,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    LoggerHelper.info(
      "==========>>Data update of -->$tableName<-- table!<<==========",
    );
    return await db.update(tableName, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String tableName, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> query(
    String tableName, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return await db.query(
      tableName,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<bool> tableExists(String tableName) async {
    final db = await database;
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return result.isNotEmpty;
  }

  Future<void> deleteAllTables() async {
    final db = await database;

    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table'",
    );

    for (var table in tables) {
      final tableName = table['name'];
      await db.execute('DROP TABLE $tableName');
      LoggerHelper.info(
        "==========>>Table -->$tableName<-- DELETED!<<==========",
      );
    }

    LoggerHelper.info("==========>>All tables deleted!<<==========");
  }

  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;

    LoggerHelper.info("==========>>Db closed<<==========");
  }
}
