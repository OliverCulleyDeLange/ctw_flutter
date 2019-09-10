import 'package:ctw_flutter/data/db.dart';
import 'package:ctw_flutter/domain/app-state.dart';
import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/domain/scoring.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:ctw_flutter/ui/widgets/success-popup.dart';
import 'package:ctw_flutter/ui/widgets/tile.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

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
        adUnitId: BannerAd.testAdUnitId,
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
    bannerAd = getBannerAd();
    bannerAd
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    bannerAd.dispose();
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
    List<Widget> _challengeTiles = (state.challenges ?? {})
        .values
        .toList()
        .asMap()
        .map((index, challenge) =>
        MapEntry(
            index,
            getTile(
              context,
              state,
              index,
              challenge.id.toString(),
              challenge,
              challengeScreens[challenge.name](challenge),
            )))
        .values
        .toList();

    List<Widget> _menuTiles = [
      InkWell(
          onTap: () async {
            await ChallengeProgressDB.resetDb();
            RestartWidget.restartApp(context);
          },
          child: Icon(Icons.refresh)),
      Center(
          child: Text(
            state.score.toString(),
            textScaleFactor: 2,
          ))
    ];

    List<Widget> _allTiles = _challengeTiles;
    _allTiles.addAll(_menuTiles);

    return _allTiles != null
        ? GridView.count(crossAxisCount: _gridRowSize, children: _allTiles)
        : Container();
  }

  Widget getTile(BuildContext context,
      AppState state,
      int index,
      String tileTitle,
      Challenge challenge,
      Widget challengeScreen,) {
    return ColourAnimatedTile(
        animate: challenge.completed,
        buildChild: (animate) =>
            InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => challengeScreen));
                },
                child: Text(
                  state.showCode && index < 4
                      ? state.passcode.substring(index, index + 1)
                      : tileTitle,
                  style: Theme
                      .of(context)
                      .textTheme
                      .display2,
                )));
  }
}
