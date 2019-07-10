import 'package:ctw_flutter/domain/challenge.dart';
import 'package:flutter/material.dart';

typedef BuildDynamicTitledTile = Widget Function(
    BuildContext context, String title);
typedef BuildTile = Widget Function(BuildContext context);

class AppState {
  List<Challenge> challenges;
  bool showCode = false;

  AppState({this.challenges, this.showCode});

  void updateChallengeProgress(Challenge challenge) async {}
}
