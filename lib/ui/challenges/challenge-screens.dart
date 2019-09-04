import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/ui/challenges/device/rotate.dart';
import 'package:ctw_flutter/ui/challenges/device/shake.dart';
import 'package:ctw_flutter/ui/challenges/gesture/double-tap.dart';
import 'package:ctw_flutter/ui/challenges/gesture/drag-and-drop.dart';
import 'package:ctw_flutter/ui/challenges/gesture/long-press.dart';
import 'package:ctw_flutter/ui/challenges/gesture/single-tap.dart';
import 'package:ctw_flutter/ui/challenges/input/local-auth.dart';
import 'package:ctw_flutter/ui/challenges/input/passcode.dart';
import 'package:flutter/cupertino.dart';

import 'base-challenge.dart';
import 'input/hidden-word.dart';

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
};
