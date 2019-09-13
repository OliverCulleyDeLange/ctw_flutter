import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';

import 'maze-world.dart';

class TargetComponent extends BodyComponent {
  TargetComponent(MazeWorld mazeWorld) : super(mazeWorld) {
    _createBody();
  }

  @override
  void update(double t) {
//    this.idle = body.linearVelocity.x.abs() < 0.1 && body.linearVelocity.y.abs() < 0.1;
//    this.forward = body.linearVelocity.x >= 0.0;
//    this.jumping = body.getContactList() == null;
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = 20;
    shape.p.x = 0.0;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    activeFixtureDef.restitution = 0.0;
    activeFixtureDef.density = 0.05;
    activeFixtureDef.friction = 0.2;
    FixtureDef fixtureDef = activeFixtureDef;
    final activeBodyDef = new BodyDef();
    activeBodyDef.linearVelocity = new Vector2(0.0, 0.0);
    activeBodyDef.position = new Vector2(0.0, 15.0);
    activeBodyDef.type = BodyType.DYNAMIC;
    activeBodyDef.bullet = true;
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void input(Offset position) {
    Vector2 force =
        position.dx < 250 ? new Vector2(-1.0, 0.0) : new Vector2(1.0, 0.0);
    body.applyForce(force..scale(10000.0), center);
  }

//  Drag handleDrag(Offset position) {
//    return new HandleNinjaDrag(this);
//  }

  void stop() {
    body.linearVelocity = new Vector2(0.0, 0.0);
    body.angularVelocity = 0.0;
  }
}
