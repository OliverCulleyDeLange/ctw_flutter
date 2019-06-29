import 'package:ctw_flutter/screens/challenges/0.dart';
import 'package:flutter/material.dart';

var challenges = [Challenge(Challenge0())];

class Challenge {
  Widget view;

  Challenge(this.view);
}
