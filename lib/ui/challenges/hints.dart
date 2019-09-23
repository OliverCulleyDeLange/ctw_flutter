import 'package:ctw_flutter/domain/exceptions.dart';
import 'package:flutter/material.dart';

class Hints {
  static Map<String, List<Widget>> _hints = {
    "single-tap": [Text("Tap"), Text("Tap2"), Text("Tap3"), Text("Tap4")],
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
