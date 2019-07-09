import 'dart:async';

import 'package:ctw_flutter/data/challenge-progress.dart';
import 'package:ctw_flutter/data/db.dart';
import 'package:flutter/foundation.dart';

class ChallengeProgressBloc {
  ChallengeProgressBloc() {
    getChallengeProgress();
  }

  final _challengeProgressController =
      StreamController<List<ChallengeProgress>>.broadcast();

  get challenges => _challengeProgressController.stream;

  dispose() {
    _challengeProgressController.close();
  }

  getChallengeProgress() async {
    debugPrint("DB: Getting all challenge progress");
    var allProgress = await ChallengeProgressDB.db.getAllChallengeProgress();
    _challengeProgressController.sink.add(allProgress);
  }

  add(ChallengeProgress challengeProgress) {
    debugPrint("DB: Adding challenge progress");
    ChallengeProgressDB.db.create(challengeProgress);
    getChallengeProgress();
  }

  completeChallenge(ChallengeProgress challengeProgress) {
    debugPrint("DB: Completing challenge ${challengeProgress.name}");
    ChallengeProgressDB.db.update(challengeProgress);
    getChallengeProgress();
  }
}