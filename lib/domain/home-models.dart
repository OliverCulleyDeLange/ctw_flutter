import 'package:ctw_flutter/domain/challenge.dart';
import 'package:flutter/material.dart';

import '../prefs.dart';

typedef BuildDynamicTitledTile = Widget Function(
    BuildContext context, String title);
typedef BuildTile = Widget Function(BuildContext context);

class HomeModel extends ChangeNotifier {
  Map<String, ChallengeTile> challengeTiles;
  List<MenuItemTile> menuTiles;

  int gridRowSize = 4;

  HomeModel() {
    challengeTiles = challenges.asMap().map((i, challenge) => MapEntry(
        challenge.id,
        ChallengeTile(i.toString(), challenge.getTileContent, challenge)));

    _maybeDisplayCode();

    menuTiles = [
      MenuItemTile(Icons.refresh),
      MenuItemTile(Icons.save),
      MenuItemTile(Icons.settings),
    ];
  }

  void challengeComplete(String id) {
    challengeTiles[id].challenge.complete();
    if (id == "passcode") {
      codeDisplayed(false);
    }
  }

  void challengeAttempted(String id) async {
    _maybeDisplayCode();
  }

  bool isChallengeComplete(String id) => challengeTiles[id].challenge.completed;

  Future _maybeDisplayCode() async {
    if (await getPasscodeCounter() == 0 && !isChallengeComplete('passcode')) {
      codeDisplayed(true);
    }
  }

  void codeDisplayed(bool show) async {
    if (show) {
      var _passcode = await getPasscode();
      debugPrint("Displaying code");
      for (var i = 0; i < 4; i++) {
        challengeTiles.values.toList()[i].title = _passcode.substring(i, i + 1);
      }
    } else {
      debugPrint("Hiding code");
      for (var i = 0; i < 4; i++) {
        challengeTiles.values.toList()[i].title = i.toString();
      }
    }
    notifyListeners();
  }

  setGridRowSize(double value) {
    var round = value.round();
    if (gridRowSize != round) {
//      debugPrint("Slider set to $round");
      gridRowSize = round;
      notifyListeners();
    }
  }
}

class ChallengeTile {
  BuildDynamicTitledTile get;
  String title;
  Challenge challenge;

  ChallengeTile(this.title, this.get, this.challenge)
      : assert(title != null),
        assert(get != null),
        assert(challenge != null);
}

class MenuItemTile {
  BuildTile get;
  IconData icon;

  MenuItemTile(this.icon) : assert(icon != null) {
    this.get = (context) =>
        InkWell(
        onTap: () async {
          //TODO open menu / do thing
        },
        child: Icon(icon));
  }
}
