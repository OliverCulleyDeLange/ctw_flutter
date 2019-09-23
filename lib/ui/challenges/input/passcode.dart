import 'dart:convert';
import 'dart:math';

import 'package:code_input/code_input.dart';
import 'package:ctw_flutter/ui/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

import '../../../state-container.dart';

class Passcode extends StatefulWidget {
  @override
  _PasscodeState createState() => _PasscodeState();
}

class _PasscodeState extends State<Passcode>
    with SingleTickerProviderStateMixin {
  int _counterStart = 5;
  var _inputKey = Key("input");
  bool _attempted = false;

  decrementCounter(challenge) {
    var stateJson = json.decode(challenge.state);
    var counter = stateJson['counter'];
    if (counter == null) {
      counter = _counterStart;
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
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 100),
              firstChild: const Icon(
                Icons.vpn_key,
              ),
              secondChild: const Icon(
                Icons.cancel,
              ),
              crossFadeState: !_attempted
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            CodeInput(
              key: _inputKey,
              length: 4,
              keyboardType: TextInputType.number,
              builder: CodeInputBuilders.lightCircle(),
              onFilled: (text) {
                if (text == appState.passcode.toString()) {
                  BaseChallenge.of(context).complete();
                } else {
                  BaseChallenge.of(context).attempt(1);
                  setState(() {
                    _attempted = true;
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        _attempted = false;
                        _inputKey = Key(Random().nextDouble().toString());
                      });
                    });
                  });
                }
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                counter == 0 ? Icon(Icons.lock_open) : Icon(Icons.lock_outline),
                Text(counter.toString())
              ],
            )
          ],
        ));
  }
}
