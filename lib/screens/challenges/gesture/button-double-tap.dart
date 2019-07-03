import 'package:ctw_flutter/screens/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class Challenge1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseChallenge(getChallengeWidget: (complete) {
      return GestureDetector(
        onTap: () {
          print("Simple button challenge won");
          complete(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.looks_two),
            Icon(Icons.touch_app),
          ],
        ),
      );
    });
  }
}
