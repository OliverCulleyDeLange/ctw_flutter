import 'package:ctw_flutter/screens/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return BaseChallenge(
        getChallengeWidget: (completed) =>
            RaisedButton.icon(
                icon: Icon(Icons.check_circle_outline),
                label: Text("Tap me"),
            onPressed: () {
              print("Simple button challenge won");
              completed(context);
            }));
  }
}
