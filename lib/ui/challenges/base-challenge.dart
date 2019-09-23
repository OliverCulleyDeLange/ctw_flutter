import 'dart:io';

import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/domain/scoring.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/widgets/success-popup.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app.dart';
import '../../main.dart';
import '../../state-container.dart';

class BaseChallenge extends StatefulWidget {
  final Widget child;
  final Challenge challenge;
  final Scorer scorer;

  BaseChallenge(
      {this.child, this.scorer = TimeScorer.fastThreeStar, this.challenge});

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
  int showHint = -1;

  @override
  void initState() {
    super.initState();
    debugPrint("Challenge started: ${widget.challenge.name}");
    MyApp.analytics
        .setCurrentScreen(screenName: widget.challenge.name)
        .then((_) => debugPrint("Sent current screen to GA"), onError: (e) {
      debugPrint("Failed to send current screen to GA! $e");
    });
    _stopwatch.start();
    if (enableAds) {
      interstitialAd = getHintAd()
        ..load();
    }
  }

  InterstitialAd getHintAd() =>
      InterstitialAd(
        adUnitId: getHintAdId(),
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
          testDevices: <String>["CFC6796C5F6C8026B3C8AE612F629556"],
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

    var starScore = widget.scorer.getStarScore(_stopwatch.elapsed);
    setState(() {
      _completed = true;
      _starScore = starScore;
    });
    StateContainer.of(context).updateChallengeProgress(widget.challenge,
        complete: true,
        score: widget.challenge.score + _stopwatch.elapsed.inSeconds);
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
    MyApp.analytics.logEvent(name: "level_complete", parameters: {
      "score": _stopwatch.elapsed.inSeconds,
      "stars": starScore.toString(),
      "level": widget.challenge.name,
    }).then((_) => debugPrint("Sent current screen to GA"), onError: (e) {
      debugPrint("Failed to send current screen to GA!: $e");
    });
  }

  Widget build(BuildContext context) {
    debugPrint("Building BaseChallenge { completed:$_completed }");
    return _ChallengeState(
      data: this,
      child: Scaffold(
          body: Stack(children: [
          Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
              ],
            ),
          )),
        SafeArea(
            child: Container(
                alignment: Alignment.topRight,
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                if (showHint >= 0) widget.challenge.getHint(showHint),
            if (widget.challenge.hasHints())
    FlatButton(
        onPressed: () {
          debugPrint("Hint requested");
          if (enableAds) {
            interstitialAd.show();
          }
          setState(() {
            showHint++;
          });
        },
        child: Row(
          children: <Widget>[
            Icon(Icons.help_outline),
            Icon(
              FontAwesomeIcons.ad,
              size: 25,
            ),
          ],
        ))
    ,
    ],
    )),
    ),
    ])),
    );
  }

  @override
  void dispose() {
    if (enableAds) {
      interstitialAd?.dispose();
    }
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
    return "ca-app-pub-9025204136165737/8229558246";
  else if (Platform.isIOS) return "";
}
