import 'dart:io';

import 'package:ctw_flutter/state-container.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'data/challenge-progress-repository.dart';

bool enableAds = false;

void main() => run();

void run() {
//  debugPrintGestureArenaDiagnostics = true;

  if (enableAds && Platform.isAndroid) {
    FirebaseAdMob.instance.initialize(
        appId: "ca-app-pub-9025204136165737~5839198623");
  } else if (enableAds && Platform.isIOS) {
    FirebaseAdMob.instance.initialize(
        appId: "ca-app-pub-9025204136165737~6974803433");
  }

  return runApp(RestartWidget(
      child: StateContainer(
        child: MyApp(),
        challengeProgressRepository: LocalChallengeProgressRepository(),
      )));
}
