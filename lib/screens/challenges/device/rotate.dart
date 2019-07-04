import 'package:ctw_flutter/screens/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class Rotate extends StatefulWidget {
  @override
  _RotateState createState() => _RotateState();
}

class _RotateState extends State<Rotate> {
  Orientation initOrientation;

  @override
  Widget build(BuildContext context) {
    if (initOrientation == null) {
      initOrientation = MediaQuery
          .of(context)
          .orientation;
      debugPrint("Initial orientation = $initOrientation");
    }
    return BaseChallenge(
        complete: MediaQuery
            .of(context)
            .orientation != initOrientation,
        getChallengeWidget: (complete) {
          return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.rotate_left),
                ],
              ));
        });
  }
}
