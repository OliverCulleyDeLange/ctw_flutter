import 'package:ctw_flutter/screens/challenges/gesture/button-double-tap.dart';
import 'package:ctw_flutter/screens/challenges/gesture/button-simple.dart';
import 'package:flutter/material.dart';

var challenges = [
  Challenge(SimpleButton()),
  Challenge(Challenge1())
];

class Challenge {
  Widget view;

  Challenge(this.view);
}
