import 'package:ctw_flutter/domain/home-models.dart';
import 'package:ctw_flutter/ui/challenges/device/rotate.dart';
import 'package:ctw_flutter/ui/challenges/device/shake.dart';
import 'package:ctw_flutter/ui/challenges/gesture/double-tap.dart';
import 'package:ctw_flutter/ui/challenges/gesture/drag-and-drop.dart';
import 'package:ctw_flutter/ui/challenges/gesture/long-press.dart';
import 'package:ctw_flutter/ui/challenges/gesture/single-tap.dart';
import 'package:ctw_flutter/ui/challenges/input/local-auth.dart';
import 'package:ctw_flutter/ui/challenges/input/passcode.dart';
import 'package:ctw_flutter/ui/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Challenge> challenges = [
  Challenge(
    "single-tap",
    SingleTap(),
  ),
  Challenge(
    "double-tap",
    DoubleTap(),
  ),
  Challenge(
    "long-press",
    LongPress(),
  ),
  Challenge(
    "drag-drop",
    DragAndDrop(),
  ),
  Challenge(
    "local-auth",
    LocalAuth(),
  ),
  Challenge(
    "shake",
    Shake(),
  ),
  Challenge(
    "rotate",
    Rotate(),
  ),
  Challenge(
    "passcode",
    Passcode(),
  ),
];

class Challenge {
  String id;
  BuildDynamicTitledTile getTileContent;
  Widget screen;
  bool completed = false;

  Challenge(this.id, this.screen, {this.getTileContent}) {
    if (getTileContent == null) {
      // Default tile content
      this.getTileContent = getDefaultChallengeTileBuilder(id, screen);
    }
  }

  void complete() {
    this.completed = true;
  }
}

BuildDynamicTitledTile getDefaultChallengeTileBuilder(String id,
    Widget screen) {
  return (context, title) {
    var homeModel = Provider.of<HomeViewModel>(context);
    return ColourAnimatedTile(
        buildChild: (animate) => InkWell(
            onTap: () async {
              var won = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen));
              print("Challenge result: $won");
              if (won == true) {
                animate();
                homeModel.challengeComplete(id);
              } else {
                homeModel.challengeAttempted(id);
              }
            },
            child: Text(
              title,
              style: Theme.of(context).textTheme.display2,
            )));
  };
}
