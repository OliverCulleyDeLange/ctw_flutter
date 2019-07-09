import 'package:ctw_flutter/data/challenge-progress-entity.dart';

class Challenge {
  int id;
  String name;
  int score = 0;
  bool completed = false;

  Challenge(this.name, {this.id, this.score, this.completed});

  ChallengeProgressEntity toEntity() {
    return ChallengeProgressEntity(
        id: id, score: score, completed: completed, name: name);
  }

  static Challenge fromEntity(ChallengeProgressEntity progress) {
    return Challenge(progress.name, id: progress.id,
        score: progress.score ?? 0,
        completed: progress.completed ?? false);
  }
}