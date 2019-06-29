import 'package:ctw_flutter/screens/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return BaseChallenge(
        child: FlatButton.icon(
            icon: Icon(Icons.chevron_right),
            label: Text("Win"),
            onPressed: () {
              print("Simple button challenge won");
              Navigator.pop(context, true);
            }));
  }
}
