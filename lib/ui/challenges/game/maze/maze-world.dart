import 'package:ctw_flutter/ui/challenges/game/maze/player-component.dart';
import 'package:ctw_flutter/ui/challenges/game/maze/target-component.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';

import 'demo-level.dart';

class MazeWorld extends Box2DComponent {
  TargetComponent target;
  PlayerComponent player;

  MazeWorld() : super(scale: 10);

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
    player.closeAccelerometerSubscription();
  }
}
