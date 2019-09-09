import 'package:battery/battery.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../base-challenge.dart';

var battery = Battery();

class ChargeBattery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    battery.onBatteryStateChanged.listen((BatteryState state) {
      debugPrint(state.toString());
      if (state == BatteryState.full) {
        BaseChallenge.of(context).complete();
      }
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(FontAwesomeIcons.batteryFull),
        Icon(FontAwesomeIcons.batteryThreeQuarters),
        Icon(FontAwesomeIcons.batteryHalf),
        Icon(FontAwesomeIcons.batteryQuarter),
        Icon(FontAwesomeIcons.batteryEmpty),
      ],
    );
  }
}
