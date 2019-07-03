import 'package:ctw_flutter/screens/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return BaseChallenge(getChallengeWidget: (completed) {
      return GestureDetector(
        onTap: () {
          print("Simple button challenge won");
          completed(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.looks_one),
            Icon(Icons.touch_app),
          ],
        ),
      );
    });
  }
}
