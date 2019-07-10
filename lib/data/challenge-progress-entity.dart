// https://app.quicktype.io/#l=dart
// To parse this JSON data, do
// final challengeProgress = challengeProgressFromJson(jsonString);
import 'dart:convert';

class ChallengeProgressEntity {
  final int id;
  final int score;
  final bool completed;
  final String name;
  final String state;

  ChallengeProgressEntity(
      {this.id, this.score, this.completed, this.name, this.state});

  factory ChallengeProgressEntity.fromJson(String str) =>
      ChallengeProgressEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChallengeProgressEntity.fromMap(Map<String, dynamic> json) =>
      new ChallengeProgressEntity(
        id: json["id"],
        completed: json["completed"] == 1,
        score: json["score"],
        name: json["name"],
        state: json["state"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "completed": completed,
    "score": score,
        "name": name,
    "state": state,
      };

  @override
  String toString() {
    return "[$id : $name] score: $score, completed: $completed, state: $state";
  }
}
