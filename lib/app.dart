import 'package:ctw_flutter/data/challenge-progress-repository.dart';
import 'package:ctw_flutter/domain/app-state.dart';
import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/theme.dart';
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
            challenges: challengeProgress
                .asMap()
                .map((i, c) => MapEntry(c.name, Challenge.fromEntity(c))));
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
      },
    ));
  }

  void updateChallengeProgress(Challenge challenge) {
    setState(() {}); //Weird, just to re-draw?
    challengeProgressRepository.update(challenge.toEntity());
  }
}
