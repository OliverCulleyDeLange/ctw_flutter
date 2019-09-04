import 'dart:async';

import 'package:ctw_flutter/data/challenge-progress-entity.dart';
import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/ui/challenges/challenge-screens.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// https://github.com/Rahiche/sqlite_demo/blob/sqlite_demo_bloc/lib/Database.dart
// https://medium.com/flutter-community/using-sqlite-in-flutter-187c1a82e8b
class ChallengeProgressDB {
  static final String dbName = "ctw.db";
  static final String table = "ChallengeProgress";
  static final String challengeNameIndexName = "idx_challenge_name";

  ChallengeProgressDB._();

  static final ChallengeProgressDB db = ChallengeProgressDB._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDb();
    return _database;
  }

  static resetDb() async {
    var d = await db.database;
    await d.rawDelete("DROP TABLE IF EXISTS $table");
    await db.createDb(d);
  }

  initDb() async {
    var dbPath = join(await getDatabasesPath(), dbName);
    return await openDatabase(dbPath, version: 1,
//        onOpen: (db) {},
        onCreate: (Database db, int version) async => createDb(db));
  }

  FutureOr<void> createDb(Database db) async {
    debugPrint("Creating DB Table and Index");
    await db.execute("CREATE TABLE $table ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "score INTEGER,"
        "completed INTEGER,"
        "state TEXT"
        ")");
    await db.execute(
        "CREATE UNIQUE INDEX $challengeNameIndexName on $table (name)");

    debugPrint("Initialising DB with all challenge names");

    for (String challengeName in challengeScreens.keys) {
      var entity = Challenge(challengeName).toEntity();
      await db.insert(table, entity.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  Future<List<ChallengeProgressEntity>> loadAll() async {
    debugPrint("DB: Loading all challenges");
    final db = await database;
    var res = await db.query(table);
    List<ChallengeProgressEntity> list = res.isNotEmpty
        ? res.map((c) => ChallengeProgressEntity.fromMap(c)).toList()
        : [];
    return list;
  }

  // Basic CRUD Operations
  create(ChallengeProgressEntity newChallengeProgress) async {
    debugPrint("DB: Creating challenge");
    final db = await database;
    return await db.insert(table, newChallengeProgress.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  read(int id) async {
    debugPrint("DB: Reading challenge $id");
    final db = await database;
    var res = await db.query(table, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? ChallengeProgressEntity.fromMap(res.first) : null;
  }

  update(ChallengeProgressEntity updatedProgress) async {
    debugPrint("DB: Updating challenge ${updatedProgress.toString()}");
    final db = await database;
    return db.update(table, updatedProgress.toMap(),
        where: "id = ?", whereArgs: [updatedProgress.id]);
  }

  delete(int id) async {
    debugPrint("DB: Deleting challenge $id");
    final db = await database;
    return db.delete(table, where: "id = ?", whereArgs: [id]);
  }
}
