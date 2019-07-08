import 'dart:math';

import 'package:ctw_flutter/domain/scoring.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/widgets/success-popup.dart';
import 'package:flutter/material.dart';

typedef OnCompleteFunction = Function(BuildContext context);
typedef GetChallengeWidget = Widget Function(OnCompleteFunction complete);

class BaseChallenge extends StatefulWidget {
  final GetChallengeWidget getChallengeWidget;
  final complete;

  BaseChallenge({this.getChallengeWidget, this.complete = false});

  @override
  _BaseChallengeState createState() => _BaseChallengeState();
}

class _BaseChallengeState extends State<BaseChallenge> {
  bool completed = false;
  StarScore starScore;

  complete(BuildContext context) async {
    debugPrint("Challenge completed");
    setState(() {
      completed = true;
      starScore = StarScore(Random().nextInt(3) + 1, 3); //TODO
    });
    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context, true);
  }

  Widget build(BuildContext context) {
    if (widget.complete) {
      complete(context);
    }
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // Box decoration takes a gradient
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: [0, 1],
                  colors: [
                    backgroundGradient_1,
                    backgroundGradient_2,
                  ],
                )),
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  completed
                      ? SuccessPopup(starScore)
                      : widget.getChallengeWidget(complete),
                ],
              ),
            )));
  }
}
