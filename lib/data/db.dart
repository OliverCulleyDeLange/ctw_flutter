import 'dart:async';

import 'package:ctw_flutter/data/challenge-progress-entity.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'challenge-progress-repository.dart';

// https://github.com/Rahiche/sqlite_demo/blob/sqlite_demo_bloc/lib/Database.dart
// https://medium.com/flutter-community/using-sqlite-in-flutter-187c1a82e8b
class ChallengeProgressDB extends ChallengeProgressRepository {
  final String dbName = "ctw.db";
  final String table = "ChallengeProgress";
  final String challengeNameIndexName = "idx_challenge_name";

  ChallengeProgressDB._();

  static final ChallengeProgressDB db = ChallengeProgressDB._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), dbName),
        version: 1,
        onOpen: (db) {}, onCreate: (Database db, int version) async {
          debugPrint("Creating DB Table and Index");
          await db.execute("CREATE TABLE $table ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "score INTEGER,"
              "completed INTEGER"
              ")");
          await db.execute(
              "CREATE UNIQUE INDEX $challengeNameIndexName on $table (name)");

          await db.insert(
              table,
              ChallengeProgressEntity(
                  id: 0, score: 2, completed: true, name: "single-tap")
                  .toMap());
          await db.insert(
              table,
              ChallengeProgressEntity(
                  id: 1, score: 11, completed: false, name: "double-tap")
                  .toMap());
          await db.insert(
              table,
              ChallengeProgressEntity(
                  id: 2, score: 21, completed: true, name: "long-press")
                  .toMap());
    });
  }

  @override
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
    debugPrint("DB: Loading all challenges");
    final db = await database;
    var raw = await db.insert(table, newChallengeProgress.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return raw;
  }

  read(int id) async {
    debugPrint("DB: Reading challenge $id");
    final db = await database;
    var res = await db.query(table, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? ChallengeProgressEntity.fromMap(res.first) : null;
  }

  @override
  Future update(ChallengeProgressEntity updatedProgress) async {
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
