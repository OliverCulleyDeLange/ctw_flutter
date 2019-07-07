import 'package:ctw_flutter/domain/challenge.dart';
import 'package:flutter/material.dart';

import '../prefs.dart';

typedef BuildDynamicTitledTile = Widget Function(
    BuildContext context, String title);
typedef BuildTile = Widget Function(BuildContext context);

class HomeModel extends ChangeNotifier {
  List<MenuItemTile> _menuTiles;

  List<MenuItemTile> get menuTiles => _menuTiles;

  Map<String, ChallengeTile> _challengeTiles = {};

  Iterable<ChallengeTile> get challengeTiles => _challengeTiles.values;

  int _gridRowSize = 4;

  int get gridRowSize => _gridRowSize;

  HomeModel() {
    _challengeTiles = challenges.asMap().map((i, challenge) =>
        MapEntry(
        challenge.id,
        ChallengeTile(i.toString(), challenge.getTileContent, challenge)));

    _menuTiles = [
      MenuItemTile(Icons.settings),
      MenuItemTile(Icons.save),
      MenuItemTile(Icons.refresh),
    ];

    _maybeDisplayCode();
  }

  setGridRowSize(double value) {
    var round = value.round();
    if (gridRowSize != round) {
//      debugPrint("Slider set to $round");
      _gridRowSize = round;
      notifyListeners();
    }
  }

  void challengeAttempted(String id) async {
    _maybeDisplayCode();
  }

  void challengeComplete(String id) {
    _challengeTiles[id].challenge.complete();
    if (id == "passcode") {
      _codeDisplayed(false);
    }
  }

  bool isChallengeComplete(String id) =>
      _challengeTiles[id].challenge.completed;

  Future _maybeDisplayCode() async {
    if (await getPasscodeCounter() == 0 && !isChallengeComplete('passcode')) {
      _codeDisplayed(true);
    }
  }

  void _codeDisplayed(bool show) async {
    if (show) {
      var _passcode = await getPasscode();
      debugPrint("Displaying code");
      for (var i = 0; i < 4; i++) {
        _challengeTiles.values.toList()[i].title =
            _passcode.substring(i, i + 1);
      }
    } else {
      debugPrint("Hiding code");
      for (var i = 0; i < 4; i++) {
        _challengeTiles.values.toList()[i].title = i.toString();
      }
    }
    notifyListeners();
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
