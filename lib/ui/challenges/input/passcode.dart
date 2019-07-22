import 'dart:convert';

import 'package:code_input/code_input.dart';
import 'package:ctw_flutter/ui/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

import '../../../state-container.dart';

class Passcode extends StatefulWidget {
  @override
  _PasscodeState createState() => _PasscodeState();
}

class _PasscodeState extends State<Passcode> {

  decrementCounter(challenge) {
    var stateJson = json.decode(challenge.state);
    var counter = stateJson['counter'];
    if (counter == null) {
      counter = 5;
    } else if (counter > 0) {
      counter--;
    }
    stateJson['counter'] = counter;
    challenge.state = json.encode(stateJson);
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    var appState = StateContainer
        .of(context)
        .state;
    var challenge = BaseChallenge
        .of(context)
        .widget
        .challenge;
    var counter = decrementCounter(challenge);

    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.vpn_key),
            CodeInput(
              length: 4,
              keyboardType: TextInputType.number,
              builder: CodeInputBuilders.lightCircle(),
              onFilled: (text) {
                if (text == appState.passcode.toString()) {
                  BaseChallenge.of(context).complete();
                }
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Icon(Icons.lock_open), Text(counter.toString())
              ],
            )
          ],
        ));
  }
}
