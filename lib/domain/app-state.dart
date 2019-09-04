import 'dart:convert';
import 'dart:math';

import 'package:ctw_flutter/domain/challenge.dart';
import 'package:flutter/material.dart';

typedef BuildDynamicTitledTile = Widget Function(
    BuildContext context, String title);
typedef BuildTile = Widget Function(BuildContext context);

class AppState {
  Map<String, Challenge> challenges;

  AppState({this.challenges});

  get showCode {
    var state = _getChallengeState("passcode");
    return state["counter"] == 0 && !challenges["passcode"].completed;
  }

  get passcode {
    var passcodeChallengeState = _getChallengeState("passcode");
    var passcode = passcodeChallengeState['passcode'];
    if (passcode == null) {
      passcode = Random().nextInt(9999).toString().padLeft(4, '0');
      passcodeChallengeState['passcode'] = passcode;
      challenges['passcode'].state = json.encode(passcodeChallengeState);
      debugPrint("Passcode initialised. New state:  $passcodeChallengeState");
    }
    return passcode;
  }

  get score =>
      challenges.values
          .map((c) => c.score)
          .fold(0, (p, e) => p + e);

  _getChallengeState(String challengeName) {
    try {
      return json.decode(challenges[challengeName].state);
    } catch (e) {
      debugPrint("Couldn't get state from [$challengeName] challenge");
      return null;
    }
  }
}
