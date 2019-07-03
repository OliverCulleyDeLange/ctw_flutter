import 'package:ctw_flutter/screens/challenges/gesture/double-tap.dart';
import 'package:ctw_flutter/screens/challenges/gesture/drag-and-drop.dart';
import 'package:ctw_flutter/screens/challenges/gesture/long-press.dart';
import 'package:ctw_flutter/screens/challenges/gesture/single-tap.dart';
import 'package:ctw_flutter/screens/challenges/input/password.dart';
import 'package:flutter/material.dart';

var challenges = [
  Challenge(SingleTap()),
  Challenge(DoubleTap()),
  Challenge(LongPress()),
  Challenge(DragAndDrop()),
  Challenge(Password()),
];

class Challenge {
  Widget view;

  Challenge(this.view);
}
