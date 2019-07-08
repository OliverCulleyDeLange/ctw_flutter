import 'dart:async';

import 'package:ctw_flutter/data/challenge-progress.dart';
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
      await db.execute("CREATE TABLE ChallengeProgress ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "completed BIT"
          ")");
    });
  }

  newChallengeProgress(ChallengeProgress newChallengeProgress) async {
    final db = await database;
    //get the biggest id in the table
    var table =
        await db.rawQuery("SELECT MAX(id)+1 as id FROM ChallengeProgress");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into ChallengeProgress (id,name,completed)"
        " VALUES (?,?,?)",
        [id, newChallengeProgress.name, newChallengeProgress.completed]);
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
