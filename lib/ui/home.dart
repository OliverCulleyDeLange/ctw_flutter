import 'package:ctw_flutter/data/db.dart';
import 'package:ctw_flutter/domain/app-state.dart';
import 'package:ctw_flutter/domain/challenge.dart';
import 'package:ctw_flutter/ui/challenges/device/rotate.dart';
import 'package:ctw_flutter/ui/challenges/device/shake.dart';
import 'package:ctw_flutter/ui/challenges/gesture/double-tap.dart';
import 'package:ctw_flutter/ui/challenges/gesture/drag-and-drop.dart';
import 'package:ctw_flutter/ui/challenges/gesture/long-press.dart';
import 'package:ctw_flutter/ui/challenges/gesture/single-tap.dart';
import 'package:ctw_flutter/ui/challenges/input/local-auth.dart';
import 'package:ctw_flutter/ui/challenges/input/passcode.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:ctw_flutter/ui/widgets/tile.dart';
import 'package:flutter/material.dart';

typedef GetChallengeScreen = Widget Function(Challenge challenge);

class Home extends StatefulWidget {
  final AppState appState;
  final Function updateChallengeProgress;

  Map<String, GetChallengeScreen> challengeScreens;

  Home({this.appState, this.updateChallengeProgress}) {
    this.challengeScreens = {
      "single-tap": (challenge) => SingleTap(),
      "double-tap": (challenge) => DoubleTap(),
      "long-press": (challenge) => LongPress(),
      "drag-and-drop": (challenge) => DragAndDrop(),
      "rotate": (challenge) => Rotate(),
      "shake": (challenge) => Shake(),
      "local-auth": (challenge) => LocalAuth(),
      "passcode": (challenge) => Passcode(challenge, updateChallengeProgress),
    };
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _gridRowSize = 4;

  @override
  Widget build(BuildContext context) {
    List<Widget> _challengeTiles = (widget.appState.challenges ?? {}).values
        .toList()
        .asMap()
        .map((index, challenge) =>
        MapEntry(
            index,
            buildTile(challenge, context, index)))
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

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: _allTiles != null
                ? GridView.count(
                crossAxisCount: _gridRowSize, children: _allTiles)
                : Container(),
          ),
          Slider(
            value: _gridRowSize.toDouble(),
            onChanged: (double value) {
              setState(() {
                var round = value.round();
                if (_gridRowSize != round) {
                  setState(() {
                    _gridRowSize = round;
                  });
                }
              });
            },
            max: 5,
            min: 3,
          )
        ],
      ),
    );
  }

  Widget buildTile(Challenge challenge, BuildContext context, int index) {
    return ColourAnimatedTile(
        animate: challenge.completed,
        buildChild: (animate) =>
            InkWell(
                onTap: () async {
                  var sw = Stopwatch();
                  sw.start();
                  var won = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) =>
                              widget.challengeScreens[challenge.name](
                                  challenge)));
                  sw.stop();
                  print("Challenge result: $won");
                  if (won == true) {
                    animate();
                    challenge.completed = true;
                  }
                  challenge.score = challenge.score + sw.elapsed.inSeconds;
                  widget.updateChallengeProgress(challenge);
                },
                child: Text(
                  widget.appState.showCode && index < 4
                      ? widget.appState.passcode.substring(index, index + 1)
                      : challenge.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .display2,
                )));
  }
}
