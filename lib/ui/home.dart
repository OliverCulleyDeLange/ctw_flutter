import 'dart:io';

import 'package:ctw_flutter/data/db.dart';
import 'package:ctw_flutter/domain/app-state.dart';
import 'package:ctw_flutter/domain/scoring.dart';
import 'package:ctw_flutter/ui/widgets/challenge-tile.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:ctw_flutter/ui/widgets/success-popup.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../state-container.dart';
import 'challenges/challenge-screens.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _gridRowSize = 4;
  bool showSuccessPopup = false;
  StarScore _starScore = StarScore(2, 3);
  BannerAd bannerAd;
  bool adShown = false;

  getBannerAd() =>
      BannerAd(
        adUnitId: getBannerAdId(),
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
          if (event == MobileAdEvent.loaded) {
            setState(() {
              adShown = true;
            });
          }
        },
        targetingInfo: MobileAdTargetingInfo(
          testDevices: <String>[
            "CFC6796C5F6C8026B3C8AE612F629556"
          ], // Android emulators are considered test devices
        ),
      );

  @override
  void initState() {
    if (enableAds) {
      bannerAd = getBannerAd();
      bannerAd
        ..load()
        ..show();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (enableAds) {
      bannerAd.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    final state = container.state;
//    debugPrint(
//        "Building Home screen: ${state.challenges?.entries?.map((e) => "${e
//            .value.name}:${e.value.completed}")?.reduce((val, elem) =>
//        val + ", $elem")}");

    return Stack(alignment: Alignment.center, children: <Widget>[
      getHomeScreen(state, context),
      showSuccessPopup ? SuccessPopup(_starScore) : Container(),
    ]);
  }

  Scaffold getHomeScreen(AppState state, BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: getChallengeTiles(state, context)),
          Slider(
            value: _gridRowSize.toDouble(),
            onChanged: (double value) {
              var round = value.round();
              if (_gridRowSize != round) {
                setState(() {
                  _gridRowSize = round;
                });
              }
            },
            max: 5,
            min: 3,
          ),
          Container(
            padding: adShown ? EdgeInsets.only(bottom: 50) : EdgeInsets.all(0),
          )
        ],
      ),
    );
  }

  Widget getChallengeTiles(AppState state, BuildContext context) {
    var _tiles = (state.challenges ?? {})
        .values
        .where((c) => challengeScreens[c.name] != null)
        .toList()
        .asMap() // Stupid way of doing map with index :/
        .map((index, challenge) {
      var tileLabel = state.showCode && index < 4
          ? state.passcode.substring(index, index + 1)
          : challenge.id.toString();
      return MapEntry(
          index,
          ChallengeTile(
              completed: challenge.completed,
              challengeScreen: challengeScreens[challenge.name](challenge),
              text: tileLabel));
    }).values;
    List<Widget> _challengeTiles = List<Widget>.from(_tiles);

    List<Widget> _menuTiles = [
      Center(
          child: Text(
            state.score != null ? state.score.toString() : "0",
            textScaleFactor: 2,
          )),
      InkWell(
          onTap: () async {
            await ChallengeProgressDB.resetDb();
            RestartWidget.restartApp(context);
          },
          child: Icon(Icons.refresh)),
    ];

    List<Widget> _allTiles = _challengeTiles;
    _allTiles.addAll(_menuTiles);

    return _allTiles != null
        ? GridView.count(crossAxisCount: _gridRowSize, children: _allTiles)
        : Container();
  }
}

getBannerAdId() {
  if (Platform.isAndroid)
    return "ca-app-pub-9025204136165737/2605147732";
  else if (Platform.isIOS) return "";
}
