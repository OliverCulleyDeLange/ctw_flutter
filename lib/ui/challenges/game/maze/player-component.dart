import 'dart:async';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class PlayerComponent extends BodyComponent {
  final paint = Paint()
    ..color = Colors.lightBlueAccent[400]
    ..style = PaintingStyle.fill;

  StreamSubscription<AccelerometerEvent> accelerometerSubscription;
  AccelerometerEvent latestAccelerometerEvent = AccelerometerEvent(0, 0, 0);

  PlayerComponent(Box2DComponent box2d) : super(box2d) {
    accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
//        debugPrint("Acceleromter: ${event.x.toStringAsPrecision(2)},${event.y.toStringAsPrecision(2)}");
          latestAccelerometerEvent = event;
        });

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
  void update(double t) {
    super.update(t); // needed?
//    debugPrint("$xmod $ymod ${latestAccelerometerEvent.toString()}");
    var m = 30.0;
    world.setGravity(Vector2(
        -latestAccelerometerEvent.x * m, -latestAccelerometerEvent.y * m));
//    body.linearVelocity
//      ..addScaled(
//          Vector2(-latestAccelerometerEvent.x, -latestAccelerometerEvent.y),
//          t * 10);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    canvas.drawCircle(center, radius, paint);
  }

  closeAccelerometerSubscription() {
    accelerometerSubscription.cancel();
  }
}
