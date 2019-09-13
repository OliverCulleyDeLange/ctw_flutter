import 'dart:async';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class PlayerComponent extends BodyComponent {
  final paint = Paint()
    ..color = Colors.lightBlueAccent[400]
    ..style = PaintingStyle.stroke
    ..strokeWidth = 20;

  Size canvassSize;
  double maxXLean = 3.0;
  double maxYLean = 1.5;
  double xmod = 0.0;
  double ymod = 0.0;

  StreamSubscription<AccelerometerEvent> accelerometerSubscription;
  AccelerometerEvent latestAccelerometerEvent = AccelerometerEvent(0, 0, 0);

  PlayerComponent(Box2DComponent box2d) : super(box2d) {
    accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
//        debugPrint("Acceleromter: ${event.x.toStringAsPrecision(2)},${event.y.toStringAsPrecision(2)}");
          latestAccelerometerEvent = event;
        });
    _createBody();
  }

  @override
  void update(double t) {
    super.update(t); // needed?
//    debugPrint("$xmod $ymod ${latestAccelerometerEvent.toString()}");
    body.linearVelocity = body.linearVelocity
      ..addScaled(
          Vector2(-latestAccelerometerEvent.x, -latestAccelerometerEvent.y),
          0.5);
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = 10;
    shape.p.x = 0.0;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    activeFixtureDef.restitution = 0.0;
    activeFixtureDef.density = 0.05;
    activeFixtureDef.friction = 0.2;
    FixtureDef fixtureDef = activeFixtureDef;
    final activeBodyDef = new BodyDef();
    activeBodyDef.linearVelocity = new Vector2(0.0, 0.0);
    activeBodyDef.position = new Vector2(0.0, 50.0);
    activeBodyDef.type = BodyType.DYNAMIC;
//    activeBodyDef.bullet = true;
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  void resize(Size size) {
    debugPrint("Player resize");
    canvassSize = size;
  }

  closeAccelerometerSubscription() {
    accelerometerSubscription.cancel();
  }
}
