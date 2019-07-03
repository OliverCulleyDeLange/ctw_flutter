import 'package:ctw_flutter/screens/widgets/success-popup.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:flutter/material.dart';

class BaseChallenge extends StatelessWidget {
  final Function getChallengeWidget;

  BaseChallenge({this.getChallengeWidget});

  complete(BuildContext context) {
    Navigator.pop(context, true);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                    gradient1_1,
                    gradient1_2,
                  ],
                )),
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SuccessPopup(),
                  getChallengeWidget(complete),
                ],
              ),
            )));
  }
}
