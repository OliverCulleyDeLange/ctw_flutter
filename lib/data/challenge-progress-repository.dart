import 'dart:async';

import 'package:ctw_flutter/data/challenge-progress-entity.dart';
import 'package:ctw_flutter/data/db.dart';

import 'challenge-progress-entity.dart';

abstract class ChallengeProgressRepository {
  Future<List<ChallengeProgressEntity>> loadAll();

  Future update(ChallengeProgressEntity progress);
}

// Can be extended to get from firestore later
class LocalChallengeProgressRepository extends ChallengeProgressRepository {
  ChallengeProgressDB db = ChallengeProgressDB.db;

  @override
  Future<List<ChallengeProgressEntity>> loadAll() {
    return db.loadAll();
  }

  @override
  Future update(ChallengeProgressEntity progress) {
    return db.update(progress);
  }

}