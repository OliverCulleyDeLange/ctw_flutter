import 'package:ctw_flutter/screens/challenges/base-challenge.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DragAndDrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseChallenge(getChallengeWidget: (complete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.touch_app),
          Draggable(
            onDragEnd: (details) {
              if (details.wasAccepted) {
                complete(context);
              }
            },
            child: Icon(FontAwesomeIcons.recycle),
            feedback: Icon(
              FontAwesomeIcons.recycle,
            ),
            childWhenDragging: Icon(
              FontAwesomeIcons.recycle,
              color: Colors.white30,
            ),
          ),
          DragTarget(
            builder:
                (BuildContext context, List candidateData, List rejectedData) {
              return Icon(FontAwesomeIcons.trash);
            },
          )
        ],
      );
    });
  }
}
