import 'package:ctw_flutter/domain/scoring.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/widgets/success-popup.dart';
import 'package:flutter/material.dart';

typedef OnCompleteFunction = Function(BuildContext context);
typedef GetChallengeWidget = Widget Function(OnCompleteFunction complete);

class BaseChallenge extends StatefulWidget {
  final GetChallengeWidget getChallengeWidget;
  final bool complete;
  final Scorer scorer;

  BaseChallenge(
      {this.getChallengeWidget, this.complete = false, this.scorer = TimeScorer
          .fastThreeStar });

  @override
  _BaseChallengeState createState() => _BaseChallengeState();
}

class _BaseChallengeState extends State<BaseChallenge> {
  bool _completed = false;
  StarScore _starScore;
  Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
  }

  complete(BuildContext context) async {
    debugPrint("Challenge completed");
    setState(() {
      _completed = true;
      _starScore = widget.scorer.getStarScore(_stopwatch.elapsed);
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
                  _completed
                      ? SuccessPopup(_starScore)
                      : widget.getChallengeWidget(complete),
                ],
              ),
            )));
  }
}
