import 'package:ctw_flutter/screens/challenges/gesture/double-tap.dart';
import 'package:ctw_flutter/screens/challenges/gesture/drag-and-drop.dart';
import 'package:ctw_flutter/screens/challenges/gesture/long-press.dart';
import 'package:ctw_flutter/screens/challenges/gesture/single-tap.dart';
import 'package:ctw_flutter/screens/challenges/input/passcode.dart';
import 'package:flutter/material.dart';

import 'screens/challenges/input/local-auth.dart';

var challenges = [
  Challenge(SingleTap()),
  Challenge(DoubleTap()),
  Challenge(LongPress()),
  Challenge(DragAndDrop()),
  Challenge(Passcode()),
  Challenge(LocalAuth()),
];

class Challenge {
  Widget view;

  Challenge(this.view);
}
