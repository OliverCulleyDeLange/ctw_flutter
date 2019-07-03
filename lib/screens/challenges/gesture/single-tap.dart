import 'package:ctw_flutter/screens/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class SingleTap extends StatelessWidget {
  Widget build(BuildContext context) {
    return BaseChallenge(getChallengeWidget: (completed) {
      return GestureDetector(
        onTap: () {
          completed(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.touch_app),
            Icon(Icons.looks_one),
          ],
        ),
      );
    });
  }
}
