import 'package:ctw_flutter/domain/exceptions.dart';
import 'package:flutter/material.dart';

class Hints {
  static Map<String, List<Widget>> _hints = {
    "double-tap": [Text("Double the previous challenge")],
    "long-press": [Text("Patience")],
    "drag-and-drop": [Text("Always sort your recyling")],
    "rotate": [Text("Locked in portrait mode?")],
    "shake": [Text("... Rattle and roll")],
    "passcode": [Text("Take a step back"), Text("Is the code unlocked yet?")],
    "hidden-word": [Text("3, 2, 1, Blast off."), Text("Turn your brightness up")],
    "sort": [Text("Oppinions, not fact")],
    "battery": [Text("Juice please")],
    "spring": [Text("Opposites attract")],
  };

  static Widget get(String name, int hintNumber) {
    var hints = _hints[name];
    var numHints = hints?.length ?? 0;
    if (numHints > 0) {
      var getHintAt = hintNumber % numHints;
      debugPrint("$hintNumber % $numHints = $getHintAt");
      return hints[getHintAt];
    } else {
      throw HintException("No hints found for $name");
    }
  }

  static bool exist(String name) {
    return (_hints[name]?.length ?? 0) > 0;
  }
}
