import 'package:ctw_flutter/domain/home-models.dart';
import 'package:ctw_flutter/ui/widgets/tile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final AppState appState;
  final Function updateChallengeProgress;

  Home({this.appState, this.updateChallengeProgress});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _gridRowSize = 4;

  @override
  Widget build(BuildContext context) {
    var _challengeTiles = widget.appState.challenges
        ?.map((challenge) =>
        ColourAnimatedTile(
            animate: challenge.completed,
            buildChild: (animate) =>
                InkWell(
                    onTap: () async {
                      var sw = Stopwatch();
                      sw.start();
                      var won = await Navigator.pushNamed(
                          context, challenge.name);
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
                      challenge.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .display2,
                    ))))
        ?.toList();
    var _allTiles = _challengeTiles;

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
}
