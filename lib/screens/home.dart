import 'package:ctw_flutter/challenges.dart';
import 'package:ctw_flutter/screens/widgets/challenge-tile.dart';
import 'package:flutter/material.dart';

import '../prefs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int passcodeCounter;
  String passcode;
  bool passcodeChallengeCompleted = false; //TODO

  _getPasswordCounter() async {
    var _counter = await getPasscodeCounter();
    setState(() {
      passcodeCounter = _counter;
    });
  }

  _getPassword() async {
    var _passcode = await getPasscode();
    setState(() {
      passcode = _passcode;
    });
  }

  @override
  void initState() {
    _getPasswordCounter();
    _getPassword();
  }

  @override
  Widget build(BuildContext context) {
    var tiles =
    List.generate(challenges.length, (index) => ChallengeTile(index));

    if (passcodeCounter == 0 && !passcodeChallengeCompleted) {
      tiles[0].displayNumber = passcode.substring(0, 1);
      tiles[1].displayNumber = passcode.substring(1, 2);
      tiles[2].displayNumber = passcode.substring(2, 3);
      tiles[3].displayNumber = passcode.substring(3, 4);
    }

    return GridView.count(crossAxisCount: 4, children: tiles);
  }
}
