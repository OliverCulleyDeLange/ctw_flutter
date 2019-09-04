import 'dart:math';

import 'package:code_input/code_input.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../base-challenge.dart';

class HiddenWord extends StatefulWidget {
  @override
  _HiddenWordState createState() => _HiddenWordState();
}

class _HiddenWordState extends State<HiddenWord> {
  String hiddenWord;
  int alpha = 0;

  @override
  void initState() {
    hiddenWord = all.elementAt(Random().nextInt(4000));
  }

  @override
  Widget build(BuildContext context) {
//    var appState = StateContainer.of(context).state;
//    var challenge = BaseChallenge.of(context).widget.challenge;
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        DecoratedBox(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Text(hiddenWord.toString(),
                style: TextStyle(
                    color: Color.fromARGB(alpha, 0, 0, 0),
                    fontSize: 100,
                    fontWeight: FontWeight.w900)),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: LongPressDraggable(
                    onDragEnd: (d) {
                      var direction = d.velocity.pixelsPerSecond.direction;
                      var upVelocity = d.velocity.pixelsPerSecond.dy;
                      debugPrint(
                          "Up Velocity: $upVelocity, direction: $direction");
                      if (upVelocity < -3000 &&
                          direction > -1 &&
                          direction < 0.5) {
                        var newAlpha =
                            ((min(20000, upVelocity.abs()) / 20000) * 10)
                                .toInt();
                        debugPrint(newAlpha.toString());
                        setState(() {
                          alpha = newAlpha;
                        });
                        debugPrint("Blast off!");
                      }
                    },
                    child: Icon(FontAwesomeIcons.rocket),
                    feedback: Icon(FontAwesomeIcons.rocket),
                    childWhenDragging: Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: false,
                        child: Icon(
                          FontAwesomeIcons.rocket,
                        )),
                  ),
                ),
                Icon(FontAwesomeIcons.globeAmericas),
              ],
            ),
          ),
        ),
        CodeInput(
          length: hiddenWord.toString().length,
          keyboardType: TextInputType.text,
          builder: (bool hasFocus, String char) => Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
//              width: 50,
//              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white)),
//                  color: color,
              ),
              child: Text(
                char,
                style: Theme.of(context).textTheme.display2,
              ),
            ),
          ),
          onFilled: (value) {
            if (value == hiddenWord) {
              BaseChallenge.of(context).complete();
            }
          },
        ),
      ],
    ));
  }
}
