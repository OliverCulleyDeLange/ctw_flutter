import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';

class PlayerComponent extends BodyComponent {
  final paint = Paint()
    ..color = Colors.lightBlueAccent[400]
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  PlayerComponent(Box2DComponent box2d) : super(box2d) {
    this.body = world.createBody(BodyDef()
      ..linearDamping = 1
      ..linearVelocity = new Vector2(0.0, 0.0)
      ..position = new Vector2(-10.0, -10.0)
      ..type = BodyType.DYNAMIC)
      ..createFixtureFromFixtureDef(FixtureDef()
        ..userData = "player"
        ..shape = (new CircleShape()
          ..radius = 0.75
          ..p.x = 0.0)
        ..restitution = 1.0
        ..density = 1.0
        ..friction = 0.2);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    canvas.drawCircle(center, radius, paint);
//    var distance = center - Offset(viewport.center.x, viewport.center.y);
    canvas.drawLine(Offset(viewport.center.x, viewport.center.y),
        Offset(center.dx, center.dy), paint);
  }
}
