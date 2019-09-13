import 'package:box2d_flame/box2d.dart';
import 'package:ctw_flutter/ui/challenges/game/maze/player-component.dart';
import 'package:ctw_flutter/ui/challenges/game/maze/target-component.dart';
import 'package:flame/box2d/box2d_component.dart';

import 'demo-level.dart';

class MazeWorld extends Box2DComponent {
  TargetComponent target;

  PlayerComponent player;

  MazeWorld() : super(scale: 4.0);

  @override
  void initializeWorld() {
    world.setGravity(Vector2(0, 0));
    addAll(new DemoLevel(this).bodies); //Maze walls
    add(target = TargetComponent(this)); //Maze target
    add(player = PlayerComponent(this));
  }

  void destroyWorld() {
    player.closeAccelerometerSubscription();
  }

//  @override
//  void update(t) {
//    super.update(t);
//    cameraFollow(target, horizontal: 0.4, vertical: 0.4);
//  }

//  void handleTap(Offset position) {
//    target.stop();
//  }

//  Drag handleDrag(Offset position) {
//    return target.handleDrag(position);
//  }
}
