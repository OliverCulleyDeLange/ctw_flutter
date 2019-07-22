import 'package:ctw_flutter/state-container.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'data/challenge-progress-repository.dart';

void main() => run();

void run() {
  return runApp(RestartWidget(
      child: StateContainer(
        child: MyApp(),
        challengeProgressRepository: LocalChallengeProgressRepository(),
      )));
}
