import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';

class PlayerComponent extends BodyComponent {
  final paint = Paint()
    ..color = Colors.lightBlueAccent[400]
    ..style = PaintingStyle.fill;

  PlayerComponent(Box2DComponent box2d) : super(box2d) {
    this.body = world.createBody(BodyDef()
      ..linearDamping = 1
      ..linearVelocity = new Vector2(0.0, 0.0)
      ..position = new Vector2(0.0, 10)
      ..type = BodyType.DYNAMIC)
      ..createFixtureFromFixtureDef(FixtureDef()
        ..shape = (new CircleShape()
          ..radius = 1
          ..p.x = 0.0)
        ..restitution = .2
        ..density = 1.0
        ..friction = 0.2);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    canvas.drawCircle(center, radius, paint);
  }
}
