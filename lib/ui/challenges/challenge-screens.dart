import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/ui/challenges/game/maze/maze.dart';
import 'package:flutter/cupertino.dart';

import 'base-challenge.dart';
import 'device/charge-battery.dart';
import 'device/rotate.dart';
import 'device/shake.dart';
import 'gesture/double-tap.dart';
import 'gesture/drag-and-drop.dart';
import 'gesture/long-press.dart';
import 'gesture/single-tap.dart';
import 'gesture/sort.dart';
import 'input/hidden-word.dart';
import 'input/local-auth.dart';
import 'input/passcode.dart';

GetChallengeScreen wrapChallenge(challengeScreen) =>
    (challenge) => BaseChallenge(
          challenge: challenge,
          child: challengeScreen,
        );

typedef GetChallengeScreen = Widget Function(Challenge challenge);

final Map<String, GetChallengeScreen> challengeScreens = {
  "single-tap": wrapChallenge(SingleTap()),
  "double-tap": wrapChallenge(DoubleTap()),
  "long-press": wrapChallenge(LongPress()),
  "drag-and-drop": wrapChallenge(DragAndDrop()),
  "rotate": wrapChallenge(Rotate()),
  "shake": wrapChallenge(Shake()),
  "local-auth": wrapChallenge(LocalAuth()),
  "passcode": wrapChallenge(Passcode()),
  "hidden-word": wrapChallenge(HiddenWord()),
  "sort": wrapChallenge(Sort()),
  "battery": wrapChallenge(ChargeBattery()),
  "maze": wrapChallenge(MazeChallenge()),
};
