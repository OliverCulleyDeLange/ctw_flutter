import 'package:ctw_flutter/screens/widgets/success-popup.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:flutter/material.dart';

typedef OnCompleteFunction = Function(BuildContext context);
typedef GetChallengeWidget = Widget Function(OnCompleteFunction complete);

class BaseChallenge extends StatefulWidget {
  final GetChallengeWidget getChallengeWidget;

  BaseChallenge({this.getChallengeWidget});

  @override
  _BaseChallengeState createState() => _BaseChallengeState();
}

class _BaseChallengeState extends State<BaseChallenge> {
  bool completed = false;

  complete(BuildContext context) async {
    setState(() {
      completed = true;
    });
    await Future.delayed(Duration(seconds: 1));
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
                    backgroundGradient_1,
                    backgroundGradient_2,
                  ],
                )),
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  completed
                      ? SuccessPopup()
                      : widget.getChallengeWidget(complete),
                ],
              ),
            )));
  }
}
