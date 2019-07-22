import 'package:ctw_flutter/ui/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class LongPress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onLongPress: () {
          BaseChallenge.of(context).complete();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.touch_app),
            Icon(Icons.hourglass_empty),
          ],
        ),
      );
  }
}
