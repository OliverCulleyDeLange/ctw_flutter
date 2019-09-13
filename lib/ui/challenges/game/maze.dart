import 'dart:async';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'maze/maze-world.dart';
import 'maze/player-positioned.dart';

class MazeChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MazeGame().widget;
  }
}

class MazeGame extends BaseGame {
  StreamSubscription<AccelerometerEvent> accelerometer;

  Player player;
  MazeWorld mazeWorld = MazeWorld();

  MazeGame() {
    mazeWorld.initializeWorld();
    player = Player(accelerometer);
    add(player);
    add(mazeWorld);
  }


  @override
  void onAttach() {
    debugPrint("Game attach");
    accelerometer = accelerometerEvents.listen(player.accelerometerListener);
  }

  @override
  void onDetach() {
    debugPrint("Game detatch");
    accelerometer.cancel();
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    debugPrint("Game state now: $state");
  }
}


