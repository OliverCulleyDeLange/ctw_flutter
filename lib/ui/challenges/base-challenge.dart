import 'dart:io';

import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/domain/scoring.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/widgets/success-popup.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../state-container.dart';

class BaseChallenge extends StatefulWidget {
  final Widget child;
  final Challenge challenge;
  final Scorer scorer;

  BaseChallenge({this.child, this.scorer = TimeScorer.fastThreeStar, this.challenge});

  static _BaseChallengeState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_ChallengeState)
    as _ChallengeState)
        .data;
  }

  @override
  _BaseChallengeState createState() => _BaseChallengeState();
}

class _BaseChallengeState extends State<BaseChallenge> {
  bool _completed = false;
  StarScore _starScore;
  Stopwatch _stopwatch = Stopwatch();
  InterstitialAd interstitialAd;

  @override
  void initState() {
    super.initState();
    debugPrint("Challenge started: ${widget.challenge.name}");
    _stopwatch.start();
    interstitialAd = getHintAd()
      ..load();
  }

  InterstitialAd getHintAd() =>
      InterstitialAd(
        // Replace the testAdUnitId with an ad unit id from the AdMob dash.
        // https://developers.google.com/admob/android/test-ads
        // https://developers.google.com/admob/ios/test-ads
        adUnitId: InterstitialAd.testAdUnitId,
        listener: (MobileAdEvent event) {
          debugPrint("InterstitialAd event is $event");
          if (event == MobileAdEvent.failedToLoad) {
            interstitialAd..load();
          } else if (event == MobileAdEvent.closed) {
            interstitialAd = getHintAd()
              ..load();
          }
        },
        targetingInfo: MobileAdTargetingInfo(
          keywords: <String>['game', 'puzzle'],
          contentUrl: 'https://flutter.io',
          childDirected: false,
          testDevices: <String>[
          ], // Android emulators are considered test devices
        ),
      );


  attempt(int scoreToAdd) async {
    debugPrint(
        "Challenge attempted: ${widget.challenge
            .name}. Current time: ${_stopwatch.elapsed.inSeconds} seconds");
    StateContainer.of(context).updateChallengeProgress(widget.challenge,
        score: widget.challenge.score + scoreToAdd);
  }

  complete() async {
    _stopwatch.stop();
    debugPrint(
        "Challenge completed: ${widget.challenge.name} in ${_stopwatch.elapsed
            .inSeconds} seconds");
    debugPrint("setState in BaseChallengeState");
    setState(() {
      _completed = true;
      _starScore = widget.scorer.getStarScore(_stopwatch.elapsed);
    });
    StateContainer.of(context).updateChallengeProgress(widget.challenge,
        complete: true,
        score: widget.challenge.score + _stopwatch.elapsed.inSeconds);
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  Widget build(BuildContext context) {
    debugPrint("Building BaseChallenge { completed:$_completed }");
    return _ChallengeState(
      data: this,
      child: Scaffold(
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
                    _completed ? SuccessPopup(_starScore) : widget.child,
                    Container(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () {
                              debugPrint("Hint requested");
                              interstitialAd.show();
                            },
                            icon: Icon(Icons.help_outline)))
                  ],
                ),
              ))),
    );
  }

  @override
  void dispose() {
    interstitialAd?.dispose();
    super.dispose();
  }
}

class _ChallengeState extends InheritedWidget {
  final _BaseChallengeState data;

  _ChallengeState({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

getHintAdId() {
  if (Platform.isAndroid)
    return "hintca-app-pub-9025204136165737/8229558246";
  else if (Platform.isIOS) return "";
}
