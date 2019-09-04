import 'dart:convert';

import 'package:code_input/code_input.dart';
import 'package:ctw_flutter/ui/challenges/base-challenge.dart';
import 'package:flutter/material.dart';

import '../../../state-container.dart';

class CustomAnimatedIcon extends AnimatedWidget {
  CustomAnimatedIcon({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class Passcode extends StatefulWidget {
  @override
  _PasscodeState createState() => _PasscodeState();
}

class _PasscodeState extends State<Passcode>
    with SingleTickerProviderStateMixin {
  bool attempted;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  decrementCounter(challenge) {
    var stateJson = json.decode(challenge.state);
    var counter = stateJson['counter'];
    if (counter == null) {
      counter = 1;
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
            CustomAnimatedIcon(animation: animation,),
            CodeInput(
              length: 4,
              keyboardType: TextInputType.number,
              builder: CodeInputBuilders.lightCircle(),
              onFilled: (text) {
                if (text == appState.passcode.toString()) {
                  BaseChallenge.of(context).complete();
                } else {
                  BaseChallenge.of(context).attempt(1);
                  setState(() {
                    attempted = true;
                  });
                }
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Icon(Icons.lock_open), Text(counter.toString())],
        )
      ],
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
