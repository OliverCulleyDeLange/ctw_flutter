import 'package:ctw_flutter/data/challenge-progress-repository.dart';
import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/domain/home-models.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/challenges/gesture/double-tap.dart';
import 'package:ctw_flutter/ui/challenges/gesture/long-press.dart';
import 'package:ctw_flutter/ui/challenges/gesture/single-tap.dart';
import 'package:ctw_flutter/ui/home.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:flutter/material.dart';

import 'data/db.dart';

class MyApp extends StatefulWidget {
  final ChallengeProgressRepository challengeProgressRepository =
      ChallengeProgressDB.db;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppState appState = AppState();

  @override
  void initState() {
    super.initState();
    widget.challengeProgressRepository.loadAll().then((challengeProgress) {
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
      },
    ));
  }

  void updateChallengeProgress(Challenge challenge) {
    setState(() {}); //Weird, just to re-draw?
    widget.challengeProgressRepository.update(challenge.toEntity());
  }
}
