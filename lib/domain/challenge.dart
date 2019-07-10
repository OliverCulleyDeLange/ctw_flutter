import 'package:ctw_flutter/data/challenge-progress-entity.dart';

const List<String> CHALLENGE_NAMES = [
  "single-tap",
  "double-tap",
  "long-press",
  "drag-and-drop",
  "rotate",
  "shake",
  "local-auth",
  "passcode"
];

class Challenge {
  // Make ENUM?
  int id;
  String name;
  int score;
  bool completed;
  String state;

  Challenge(this.name,
      {this.id, this.score = 0, this.completed = false, this.state = "{}"});

  ChallengeProgressEntity toEntity() {
    return ChallengeProgressEntity(
        id: id,
        score: score,
        completed: completed,
        name: name,
        state: state);
  }

  static Challenge fromEntity(ChallengeProgressEntity progress) {
    return Challenge(progress.name,
        id: progress.id,
        score: progress.score ?? 0,
        completed: progress.completed ?? false,
        state: progress.state ?? "");
  }
}
