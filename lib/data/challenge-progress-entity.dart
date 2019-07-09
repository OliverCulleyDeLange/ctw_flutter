// https://app.quicktype.io/#l=dart
// To parse this JSON data, do
// final challengeProgress = challengeProgressFromJson(jsonString);
import 'dart:convert';

class ChallengeProgressEntity {
  final int id;
  final int score;
  final bool completed;
  final String name;

  ChallengeProgressEntity({
    this.id,
    this.score,
    this.completed,
    this.name,
  });

  factory ChallengeProgressEntity.fromJson(String str) =>
      ChallengeProgressEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChallengeProgressEntity.fromMap(Map<String, dynamic> json) =>
      new ChallengeProgressEntity(
        id: json["id"],
        completed: json["completed"] == 1,
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "completed": completed,
        "name": name,
      };

  @override
  String toString() {
    return "[$id : $name] score: $score, completed: $completed";
  }


}
