import 'dart:convert';

import 'package:ctw_flutter/domain/challenge.dart';
import 'package:flutter/material.dart';

typedef BuildDynamicTitledTile = Widget Function(
    BuildContext context, String title);
typedef BuildTile = Widget Function(BuildContext context);

class AppState {
  Map<String, Challenge> challenges;

  AppState({this.challenges});

  get showCode {
    return getChallengeState("passcode", "counter") == 0;
  }

  get passcode {
    return getChallengeState("passcode", "passcode");
  }

  getChallengeState(String challengeName, String stateName) {
    try {
      return json.decode(challenges[challengeName].state)[stateName];
    } catch (e) {
      debugPrint(
          "Couldn't get [$stateName] state from [$challengeName] challenge");
      return null;
    }
  }

  void updateChallengeProgress(Challenge challenge) async {}
}
