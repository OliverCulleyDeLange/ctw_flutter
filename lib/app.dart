import 'package:ctw_flutter/data/challenge-progress-repository.dart';
import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/domain/home-models.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/challenges/device/rotate.dart';
import 'package:ctw_flutter/ui/challenges/device/shake.dart';
import 'package:ctw_flutter/ui/challenges/gesture/double-tap.dart';
import 'package:ctw_flutter/ui/challenges/gesture/drag-and-drop.dart';
import 'package:ctw_flutter/ui/challenges/gesture/long-press.dart';
import 'package:ctw_flutter/ui/challenges/gesture/single-tap.dart';
import 'package:ctw_flutter/ui/challenges/input/local-auth.dart';
import 'package:ctw_flutter/ui/challenges/input/passcode.dart';
import 'package:ctw_flutter/ui/home.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppState appState = AppState();
  ChallengeProgressRepository challengeProgressRepository;

  @override
  void initState() {
    challengeProgressRepository = LocalChallengeProgressRepository();
    super.initState();
    challengeProgressRepository.loadAll().then((challengeProgress) {
      setState(() {
        appState = AppState(
            challenges:
            challengeProgress.map((c) => Challenge.fromEntity(c)).toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RestartWidget(
        child: MaterialApp(
      title: "Cheat to win",
      theme: getTheme(),
      routes: {
        "/": (c) => Home(
              appState: appState,
              updateChallengeProgress: updateChallengeProgress,
            ),
        "single-tap": (c) => SingleTap(),
        "double-tap": (c) => DoubleTap(),
        "long-press": (c) => LongPress(),
        "drag-and-drop": (c) => DragAndDrop(),
        "rotate": (c) => Rotate(),
        "shake": (c) => Shake(),
        "local-auth": (c) => LocalAuth(),
        "passcode": (c) => Passcode(),
      },
    ));
  }

  void updateChallengeProgress(Challenge challenge) {
    setState(() {}); //Weird, just to re-draw?
    challengeProgressRepository.update(challenge.toEntity());
  }
}
