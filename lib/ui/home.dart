import 'package:ctw_flutter/data/db.dart';
import 'package:ctw_flutter/domain/app-state.dart';
import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/domain/scoring.dart';
import 'package:ctw_flutter/ui/challenges/device/rotate.dart';
import 'package:ctw_flutter/ui/challenges/device/shake.dart';
import 'package:ctw_flutter/ui/challenges/gesture/double-tap.dart';
import 'package:ctw_flutter/ui/challenges/gesture/drag-and-drop.dart';
import 'package:ctw_flutter/ui/challenges/gesture/long-press.dart';
import 'package:ctw_flutter/ui/challenges/gesture/single-tap.dart';
import 'package:ctw_flutter/ui/challenges/input/local-auth.dart';
import 'package:ctw_flutter/ui/challenges/input/passcode.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:ctw_flutter/ui/widgets/success-popup.dart';
import 'package:ctw_flutter/ui/widgets/tile.dart';
import 'package:flutter/material.dart';

import '../state-container.dart';
import 'challenges/base-challenge.dart';

typedef GetChallengeScreen = Widget Function(Challenge challenge);

class Home extends StatefulWidget {
  final Map<String, GetChallengeScreen> challengeScreens = {
    "single-tap": wrapChallenge(SingleTap()),
    "double-tap": wrapChallenge(DoubleTap()),
    "long-press": wrapChallenge(LongPress()),
    "drag-and-drop": wrapChallenge(DragAndDrop()),
    "rotate": wrapChallenge(Rotate()),
    "shake": wrapChallenge(Shake()),
    "local-auth": wrapChallenge(LocalAuth()),
    "passcode": wrapChallenge(Passcode()),
  };

  static wrapChallenge(challengeScreen) =>
          (challenge) =>
          BaseChallenge(
            challenge: challenge,
            child: challengeScreen,
          );

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _gridRowSize = 4;
  bool showSuccessPopup = false;
  StarScore _starScore = StarScore(2, 3);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    final state = container.state;
    debugPrint(
        "Building Home screen: ${state.challenges?.entries?.map((e) => "${e
            .value.name}:${e.value.completed}")?.reduce((val, elem) =>
        val + ", $elem")}");

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
            ColourAnimatedTile(
                animate: challenge.completed,
                buildChild: (animate) =>
                    InkWell(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) =>
                                      widget.challengeScreens[challenge.name](
                                          challenge)));
                        },
                        child: Text(
                          state.showCode && index < 4
                              ? state.passcode.substring(index, index + 1)
                              : challenge.id.toString(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .display2,
                        ))) as Widget))
        .values
        .toList();

    List<Widget> _menuTiles = [
      InkWell(
          onTap: () async {
            await ChallengeProgressDB.resetDb();
            RestartWidget.restartApp(context);
          },
          child: Icon(Icons.refresh))
    ];

    List<Widget> _allTiles = _challengeTiles;
    _allTiles.addAll(_menuTiles);

    return _allTiles != null
        ? GridView.count(crossAxisCount: _gridRowSize, children: _allTiles)
        : Container();
  }
}
