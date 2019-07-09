// https://app.quicktype.io/#l=dart
// To parse this JSON data, do
// final challengeProgress = challengeProgressFromJson(jsonString);
import 'dart:convert';

class ChallengeProgress {
  final int id;
  final int score;
  final bool completed;
  final String name;

  ChallengeProgress({
    this.id,
    this.score,
    this.completed,
    this.name,
  });

  factory ChallengeProgress.fromJson(String str) =>
      ChallengeProgress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChallengeProgress.fromMap(Map<String, dynamic> json) =>
      new ChallengeProgress(
        id: json["id"],
        completed: json["completed"] == 1,
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "completed": completed,
        "name": name,
      };
}