import 'package:ctw_flutter/ui/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

class SingleTap extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BaseChallenge.of(context).complete();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.touch_app),
          Icon(Icons.looks_one),
        ],
      ),
    );
  }
}
