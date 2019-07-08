import 'dart:async';
import 'dart:math';

import 'package:ctw_flutter/ui/challenges/base-challenge.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sensors/sensors.dart';

class Shake extends StatefulWidget {
  @override
  _ShakeState createState() => _ShakeState();
}

class _ShakeState extends State<Shake> {
  StreamSubscription<AccelerometerEvent> accelerometer;

  // All stolen from:
  // https://stackoverflow.com/questions/5271448/how-to-detect-shake-event-with-android
  static const SHAKE_THRESHOLD = 3.25; // m/S**2
  static const int MIN_TIME_BETWEEN_SHAKES_MILLISECS = 1000;

  //https://stackoverflow.com/questions/31506530/sensormanager-what-is-the-gravity-earth
  static const EARTH_GRAVITY = 9.80665;

  int lastShakeTime = 0;

  @override
  void initState() {
    super.initState();
    accelerometer = accelerometerEvents.listen((AccelerometerEvent event) {
      int curTime = DateTime.now().millisecondsSinceEpoch;
      if ((curTime - lastShakeTime) > MIN_TIME_BETWEEN_SHAKES_MILLISECS) {
        double x = event.x;
        double y = event.y;
        double z = event.z;

        double acceleration =
            sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)) - EARTH_GRAVITY;
//        debugPrint("Acceleration is $acceleration m/s^2");

        if (acceleration > SHAKE_THRESHOLD) {
          debugPrint("Shook");
          setState(() {
            lastShakeTime = curTime;
          });
          accelerometer.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    accelerometer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BaseChallenge(
        complete: lastShakeTime != 0,
        getChallengeWidget: (complete) {
          return Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(FontAwesomeIcons.handshake),
            ],
          ));
        });
  }
}
