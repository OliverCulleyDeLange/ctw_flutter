import 'dart:math';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';

import 'maze-world.dart';

class TargetComponent extends BodyComponent {

  Random random = Random();

  TargetComponent(MazeWorld mazeWorld) : super(mazeWorld) {
    this.body = world.createBody(BodyDef()
      ..linearVelocity = new Vector2(
          random.nextDouble() * 10, random.nextDouble() * 10)
      ..position = new Vector2(
          random.nextDouble() * 10, random.nextDouble() * 10)
      ..type = BodyType.DYNAMIC)
      ..createFixtureFromFixtureDef(FixtureDef()
        ..userData = "target"
        ..shape = (new CircleShape()
          ..radius = 0.5)
        ..restitution = 1.0
        ..density = 0.01
        ..friction = 0.0);
  }
}
