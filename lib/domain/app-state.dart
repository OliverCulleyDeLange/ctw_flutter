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
    var state = getChallengeState("passcode");
    return state["counter"] == 0 && !challenges["passcode"].completed;
  }

  get passcode {
    return getChallengeState("passcode")["passcode"];
  }

  getChallengeState(String challengeName) {
    try {
      return json.decode(challenges[challengeName].state);
    } catch (e) {
      debugPrint(
          "Couldn't get state from [$challengeName] challenge");
      return null;
    }
  }

  void updateChallengeProgress(Challenge challenge) async {}
}
