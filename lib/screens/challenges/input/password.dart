import 'package:code_input/code_input.dart';
import 'package:ctw_flutter/screens/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

import '../../../prefs.dart';

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  String passcode;
  int counter;

  _getCounter() async {
    var _counter = await decrementPasscodeCounter();
    setState(() {
      counter = _counter;
    });
  }

  _getPasscode() async {
    var _passcode = await getPasscode();
    setState(() {
      passcode = _passcode;
    });
  }

  @override
  void initState() {
    _getPasscode();
    _getCounter();
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
