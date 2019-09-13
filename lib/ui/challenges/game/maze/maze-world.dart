import 'package:ctw_flutter/ui/challenges/game/maze/target-component.dart';
import 'package:flame/box2d/box2d_component.dart';

import 'demo-level.dart';

class MazeWorld extends Box2DComponent {
  TargetComponent target;

  MazeWorld() : super(scale: 4.0);

  void initializeWorld() {
    addAll(new DemoLevel(this).bodies);
    add(target = TargetComponent(this));
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
