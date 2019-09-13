import 'dart:async';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class Maze extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MazeGame().widget;
  }
}

class MazeGame extends BaseGame {
  StreamSubscription<AccelerometerEvent> accelerometer;

  Player player;

  MazeGame() {
    player = Player(accelerometer);
    add(player); // this will call resize the first time as well
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

//class MazePainter extends CustomPainter {
//  double circleRadius = 50;
//  Offset pos;
//
//  MazePainter(this.pos);
//
//  @override
//  void paint(Canvas canvas, Size size) {
//
//    var midX = size.width / 2;
//    var midY = size.height / 2;
//    canvas.drawCircle(
//        Offset((pos.dx * size.width) + midX, (pos.dy * size.height) + midY),
//        circleRadius,
//        paint);
//  }
//
//  @override
//  bool shouldRepaint(MazePainter old) => false;
//}
