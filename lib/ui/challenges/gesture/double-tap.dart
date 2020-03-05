import 'package:ctw_flutter/ui/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class DoubleTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onDoubleTap: () {
          BaseChallenge.of(context).complete();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.touch_app),
            Icon(Icons.looks_two),
          ],
        ),
        ),
      );
  }
}
