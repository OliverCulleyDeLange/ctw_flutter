import 'dart:async';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class MazeChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MazeGame().widget;
  }
}

class MazeGame extends BaseGame {
  StreamSubscription<AccelerometerEvent> accelerometer;

  Player player;
  MazeWorld mazeWorld = MazeWorld();

  MazeGame() {
    mazeWorld.initializeWorld();
    player = Player(accelerometer);
    add(player);
    add(mazeWorld);
  }


  @override
  void onAttach() {
    debugPrint("Game attach");
    accelerometer = accelerometerEvents.listen(player.accelerometerListener);
  }

  @override
  void onDetach() {
    debugPrint("Game detatch");
    accelerometer.cancel();
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    debugPrint("Game state now: $state");
  }
}

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

class Player extends PositionComponent {
  final paint = Paint()
    ..color = Colors.lightBlueAccent[400]
    ..style = PaintingStyle.stroke
    ..strokeWidth = 20;

  Size canvassSize;
  double maxXLean = 3.0;
  double maxYLean = 1.5;
  double xmod = 0.0;
  double ymod = 0.0;
  double speed = 0.0;

  AccelerometerEvent latestAccelerometerEvent = AccelerometerEvent(0, 0, 0);

  Player(StreamSubscription<AccelerometerEvent> accelerometer);

  void Function(AccelerometerEvent event) get accelerometerListener =>
          (AccelerometerEvent event) {
//        debugPrint("Acceleromter: ${event.x.toStringAsPrecision(2)},${event.y.toStringAsPrecision(2)}");
        latestAccelerometerEvent = event;
      };

  @override
  void render(Canvas canvas) {
    prepareCanvas(canvas);
    // 0,0 used as canvas is positioned
    canvas.drawCircle(Offset(xmod, ymod), 20, paint);
  }

  @override
  void update(double t) {
//    debugPrint("$xmod $ymod ${latestAccelerometerEvent.toString()}");
    var newXmod = xmod + latestAccelerometerEvent.x;
    var newYmod = ymod + latestAccelerometerEvent.y;
    if (newXmod.abs() < canvassSize.width / 2) {
      xmod = newXmod;
    }
    if (newYmod.abs() < canvassSize.height / 2) {
      ymod = newYmod;
    }
  }

  @override
  void resize(Size size) {
    debugPrint("Player resize");
    canvassSize = size;
    this.x = (size.width - this.width) / 2;
    this.y = (size.height - this.height) / 2;
  }
}

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

class DemoLevel {
  List<BodyComponent> _bodies = new List();

  DemoLevel(Box2DComponent box) {
    _bodies.add(new WallBody(
        box, Orientation.portrait, 1.0, 0.05, Alignment.topCenter));
    _bodies.add(new WallBody(
        box, Orientation.portrait, 1.0, 0.05, Alignment.bottomCenter));
    _bodies.add(new WallBody(
        box, Orientation.portrait, 0.05, 1.0, Alignment.centerRight));
    _bodies.add(new WallBody(
        box, Orientation.portrait, 0.05, 1.0, Alignment.centerLeft));
  }

  List<BodyComponent> get bodies => _bodies;
}

class WallBody extends BodyComponent {
  Orientation orientation;
  double widthPercent;
  double heightPercent;
  Alignment alignment;

  bool first = true;

  WallBody(Box2DComponent box, this.orientation, this.widthPercent,
      this.heightPercent, this.alignment)
      : super(box) {
    _createBody();
  }

  void _createBody() {
    double width = box.viewport.width * widthPercent;
    double height = box.viewport.height * heightPercent;

    double x = alignment.x * (box.viewport.width - width);
    double y = (-alignment.y) * (box.viewport.height - height);

    final shape = new PolygonShape();
    shape.setAsBoxXY(width / 2, height / 2);
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;

    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.2;
    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2(x / 2, y / 2);
    Body groundBody = world.createBody(bodyDef);
    groundBody.createFixtureFromFixtureDef(fixtureDef);
    this.body = groundBody;
  }
}