import 'dart:convert';
import 'dart:math';

import 'package:code_input/code_input.dart';
import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/ui/challenges/base-challenge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Passcode extends StatefulWidget {
  final Challenge challenge;
  final Function updateChallengeProgress;

  Passcode(this.challenge, this.updateChallengeProgress);

  @override
  _PasscodeState createState() => _PasscodeState();
}

class _PasscodeState extends State<Passcode> {
  String passcode;
  int counter;

  @override
  void initState() {
    super.initState();
    var stateJsonString = widget.challenge.state;
    try {
      var state = json.decode(stateJsonString);
      passcode = state['passcode'];
      counter = state['counter'];
    } catch (e) {
      debugPrint(
          "Error parsing passcode challenge state json: \"$stateJsonString\" ...Thrown: $e");
    }
    if (passcode == null) {
      passcode = Random().nextInt(9999).toString().padLeft(4, '0');
    }
    if (counter == null) {
      counter = 5;
    } else {
      counter--;
    }
    String jsonEncodedState = json.encode({
      "passcode": passcode,
      "counter": counter,
    });
    widget.challenge.state = jsonEncodedState;
    SchedulerBinding.instance.addPostFrameCallback(
            (time) => widget.updateChallengeProgress(widget.challenge));
  }

  @override
  Widget build(BuildContext context) {
    return BaseChallenge(getChallengeWidget: (complete) {
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
                  if (text == passcode.toString()) {
                    complete(context);
                  }
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Icon(Icons.lock_open), Text(counter.toString())],
              )
            ],
          ));
    });
  }
}
