import 'dart:async';

import 'package:ctw_flutter/data/challenge-progress-entity.dart';

import 'challenge-progress-entity.dart';

abstract class ChallengeProgressRepository {
  Future<List<ChallengeProgressEntity>> loadAll();

  Future update(ChallengeProgressEntity progress);
}
