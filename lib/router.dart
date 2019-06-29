import 'package:ctw_flutter/challenges.dart';
import 'package:ctw_flutter/screens/home.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Numbered challenges
  var challengeNumber = int.parse(settings.name);
  if (challengeNumber != null) {
    print("Challenge ${challengeNumber} chosen");
    return MaterialPageRoute(builder: (_) => challenges[challengeNumber].view);
  }

  // Main screen by default
  return MaterialPageRoute(builder: (_) => Home());
}
