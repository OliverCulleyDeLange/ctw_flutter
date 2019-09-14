import 'dart:async';

import 'package:box2d_flame/box2d.dart';
import 'package:ctw_flutter/ui/challenges/game/maze/player-component.dart';
import 'package:ctw_flutter/ui/challenges/game/maze/target-component.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'demo-level.dart';

class MazeWorld extends Box2DComponent {
  TargetComponent target;
  PlayerComponent player;

  StreamSubscription<AccelerometerEvent> accelerometerSubscription;

  MazeWorld() : super(scale: 10) {
    accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
//        debugPrint("Acceleromter: ${event.x.toStringAsPrecision(2)},${event.y.toStringAsPrecision(2)}");
          var m = 20.0;
          world.setGravity(Vector2(
              -event.x * m, -event.y * m));
        });
  }

  @override
  void initializeWorld() {
    addAll(new DemoLevel(this).bodies); //Maze walls
    add(target = TargetComponent(this)); //Maze target
    add(player = PlayerComponent(this));
  }

  @override
  void resize(Size size) {
    debugPrint("MazeWorld resize: ${size.toString()}");
    super.resize(size);
  }

  void destroyWorld() {
    accelerometerSubscription.cancel();
  }
}
