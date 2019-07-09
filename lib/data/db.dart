import 'dart:async';

import 'package:ctw_flutter/data/challenge-progress.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// https://github.com/Rahiche/sqlite_demo/blob/sqlite_demo_bloc/lib/Database.dart
// https://medium.com/flutter-community/using-sqlite-in-flutter-187c1a82e8b
class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "ctw.db"),
        version: 1,
        onOpen: (db) {}, onCreate: (Database db, int version) async {
          debugPrint("Creating DB Table and Index");
          await db.execute("CREATE TABLE ChallengeProgress ("
              "id INTEGER PRIMARY KEY,"
              "score INTEGER,"
              "name TEXT,"
              "completed INTEGER"
              ")");
          await db.execute(
              "CREATE UNIQUE INDEX idx_challenge_name on ChallengeProgress (name)");

          await db.insert(
              "ChallengeProgress",
              ChallengeProgress(
                  id: 0, score: 2, completed: true, name: "single-tap")
                  .toMap());
          await db.insert(
              "ChallengeProgress",
              ChallengeProgress(
                  id: 1, score: 11, completed: false, name: "double-tap")
                  .toMap());
          await db.insert(
              "ChallengeProgress",
              ChallengeProgress(
                  id: 2, score: 21, completed: true, name: "long-press")
                  .toMap());
    });
  }

  newChallengeProgress(ChallengeProgress newChallengeProgress) async {
    final db = await database;
    var raw = await db.insert("ChallengeProgress", newChallengeProgress.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return raw;
  }

  complete(ChallengeProgress challengeProgress) async {
    final db = await database;
    ChallengeProgress completed = ChallengeProgress(
        id: challengeProgress.id,
        name: challengeProgress.name,
        completed: true);
    var res = await db.update("ChallengeProgress", completed.toMap(),
        where: "id = ?", whereArgs: [challengeProgress.id]);
    return res;
  }

  updateChallengeProgress(ChallengeProgress newChallengeProgress) async {
    final db = await database;
    var res = await db.update("ChallengeProgress", newChallengeProgress.toMap(),
        where: "id = ?", whereArgs: [newChallengeProgress.id]);
    return res;
  }

  getChallengeProgress(int id) async {
    final db = await database;
    var res =
        await db.query("ChallengeProgress", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? ChallengeProgress.fromMap(res.first) : null;
  }

  Future<List<ChallengeProgress>> getCompletedChallenges() async {
    final db = await database;
    // var res = await db.rawQuery("SELECT * FROM ChallengeProgress WHERE blocked=1");
    var res = await db
        .query("ChallengeProgress", where: "completed = ? ", whereArgs: [1]);

    List<ChallengeProgress> list = res.isNotEmpty
        ? res.map((c) => ChallengeProgress.fromMap(c)).toList()
        : [];
    return list;
  }

  Future<List<ChallengeProgress>> getAllChallengeProgress() async {
    final db = await database;
    var res = await db.query("ChallengeProgress");
    List<ChallengeProgress> list = res.isNotEmpty
        ? res.map((c) => ChallengeProgress.fromMap(c)).toList()
        : [];
    return list;
  }

  deleteChallengeProgress(int id) async {
    final db = await database;
    return db.delete("ChallengeProgress", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from ChallengeProgress");
  }
}
