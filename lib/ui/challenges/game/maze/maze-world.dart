import 'dart:async';

import 'package:box2d_flame/box2d.dart';
import 'package:ctw_flutter/ui/challenges/game/maze/player-component.dart';
import 'package:ctw_flutter/ui/challenges/game/maze/target-component.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import '../../base-challenge.dart';
import 'demo-level.dart';

class MazeWorld extends Box2DComponent {
  var targetCount = 0;
  List<TargetComponent> targets = [];
  PlayerComponent player;

  StreamSubscription<AccelerometerEvent> accelerometerSubscription;

  MyContactListener myContactListener;

  BuildContext context;

  MazeWorld(this.context) : super(scale: 10) {
    accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
//          debugPrint("Acceleromter: ${event.x.toStringAsPrecision(2)},${event.y
//              .toStringAsPrecision(2)}");
          var m = 20.0;
          world.setGravity(Vector2(-event.x * m, (event.z - 6) * m));
        });
  }

  @override
  void initializeWorld() {
    addAll(new DemoLevel(this).bodies); //Maze walls
    targets.add(TargetComponent(this));
    targets.add(TargetComponent(this));
    targets.add(TargetComponent(this));
    targets.add(TargetComponent(this));
    targets.add(TargetComponent(this));
    targets.forEach((t) {
      add(t);
      targetCount++;
    });
    add(player = PlayerComponent(this));
    world.setContactListener(myContactListener = MyContactListener());
  }

  @override
  void update(t) {
    super.update(t);
    myContactListener.toDestroy?.forEach((body) {
      if (--targetCount == 0) {
        BaseChallenge.of(context).complete();
      }
      myContactListener.toDestroy.remove(body);
      world.destroyBody(body);
    });
  }

  @override
  void resize(Size size) {
    debugPrint("MazeWorld resize: ${size.toString()}");
    super.resize(size);
  }

  void destroyWorld() {
    accelerometerSubscription.cancel();
  }
}

class MyContactListener extends ContactListener {
  List<Body> toDestroy = [];

  @override
  void beginContact(Contact contact) {
    var a = contact.fixtureA.userData;
    var b = contact.fixtureB.userData;
    if (a != null && b != null && a != b) {
      debugPrint("${a}, ${contact.fixtureB.userData}");

      var targetToDestroy = [contact.fixtureB, contact.fixtureA]
          .firstWhere((f) => f.userData == "target");
      toDestroy.add(targetToDestroy.getBody());
    }
  }

  @override
  void endContact(Contact contact) {
    // TODO: implement endContact
  }

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO: implement postSolve
  }

  @override
  void preSolve(Contact contact, Manifold oldManifold) {
    // TODO: implement preSolve
  }
}
