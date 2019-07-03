import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREF_PASSCODE_COUNTER = 'passcode-counter';
const PREF_PASSCODE = 'passcode';

Future<String> getPasscode() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var _passcode = _prefs.getString(PREF_PASSCODE);
  if (_passcode == null) {
    _passcode = Random(2867).nextInt(9999).toString().padLeft(4, '0');
    await _prefs.setString(PREF_PASSCODE, _passcode);
    debugPrint("Passcode generated: $_passcode");
  }
  return _passcode;
}

Future<int> getPasscodeCounter() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var _counter = _prefs.getInt(PREF_PASSCODE_COUNTER);
  if (_counter == null) {
    _counter = 5;
    await _prefs.setInt(PREF_PASSCODE_COUNTER, _counter);
    debugPrint("Passcode counter set to: $_counter");
  }
  return _counter;
}

Future<int> decrementPasscodeCounter() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var _counter = await getPasscodeCounter();
  if (_counter > 0 && _counter <= 5) {
    _counter--;
  } else {
    _counter = 0;
  }
  _prefs.setInt(PREF_PASSCODE_COUNTER, _counter);
  return _counter;
}
