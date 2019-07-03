import 'package:ctw_flutter/screens/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class Challenge1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseChallenge(
        getChallengeWidget: (complete) =>
            GestureDetector(
      child: Icon(Icons.looks_two),
      onDoubleTap: () {
        print("Double tap button challenge won");
        complete(context);
      },
    ));
  }
}
