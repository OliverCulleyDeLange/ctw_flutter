import 'dart:async';

import 'package:battery/battery.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../base-challenge.dart';

var battery = Battery();

class ChargeBattery extends StatefulWidget {
  @override
  _ChargeBatteryState createState() => _ChargeBatteryState();
}

class _ChargeBatteryState extends State<ChargeBattery> {
  StreamSubscription<BatteryState> batterySubscription;


  @override
  void initState() {
    batterySubscription =
        battery.onBatteryStateChanged.listen((BatteryState state) {
          debugPrint(state.toString());
          if (state == BatteryState.full) {
            BaseChallenge.of(context).complete();
          }
        });
  }

  @override
  void dispose() {
    batterySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
