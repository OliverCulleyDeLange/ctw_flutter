import 'package:flutter/material.dart';

import '../base-challenge.dart';

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
    } else if (MediaQuery
        .of(context)
        .orientation != initOrientation) {
      BaseChallenge.of(context).complete();
    }
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.rotate_left),
          ],
        ));
  }
}
