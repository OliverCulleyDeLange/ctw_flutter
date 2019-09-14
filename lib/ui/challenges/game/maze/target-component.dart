import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';

import 'maze-world.dart';

class TargetComponent extends BodyComponent {
  TargetComponent(MazeWorld mazeWorld) : super(mazeWorld) {
    this.body = world.createBody(BodyDef()
      ..linearVelocity = new Vector2(0.0, 0.0)
      ..position = new Vector2(0.0, 0.0)
      ..type = BodyType.DYNAMIC)
      ..createFixtureFromFixtureDef(FixtureDef()
        ..shape = (new CircleShape()
          ..radius = 1.5)
        ..restitution = .1
        ..density = 0.05
        ..friction = 0.0);
  }

  void input(Offset position) {
    Vector2 force =
        position.dx < 250 ? new Vector2(-1.0, 0.0) : new Vector2(1.0, 0.0);
    body.applyForce(force..scale(10000.0), center);
  }
}
