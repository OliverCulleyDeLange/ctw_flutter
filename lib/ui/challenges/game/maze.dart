import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class Maze extends StatefulWidget {
  @override
  _MazeState createState() => _MazeState();
}

class _MazeState extends State<Maze> with SingleTickerProviderStateMixin {
  AnimationController _animation;
  StreamSubscription<AccelerometerEvent> accelerometer;

//  GyroscopeEvent gyro;
  AccelerometerEvent accelEvent;

  @override
  void initState() {
    super.initState();
//    gyro = GyroscopeEvent(0, 0, 0);
    accelEvent = AccelerometerEvent(0, 0, 0);
    accelerometer = accelerometerEvents.listen((AccelerometerEvent event) {
//      debugPrint("Acceleromter: ${event.x.toStringAsPrecision(2)},${event.y.toStringAsPrecision(2)}");
      setState(() {
        accelEvent = event;
      });
    });
//    gyroscopeEvents.listen((GyroscopeEvent event) {
//      debugPrint("Gyroscope:    ${event.x.toStringAsPrecision(2)},${event.y.toStringAsPrecision(2)}");
//      setState(() {
//        gyro = event;
//      });
//    });

    _animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animation.repeat();
  }

  @override
  void dispose() {
    accelerometer.cancel();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    return RotationTransition(
//      child:
    return CustomPaint(
      size: Size.infinite,
      painter: MazePainter(accelEvent),
    ); //,
//      turns: _animation,
//    );
  }
}

class MazePainter extends CustomPainter {
  double circleRadius = 50;

//  GyroscopeEvent pos;
  AccelerometerEvent pos;

  MazePainter(this.pos);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlueAccent[400]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
//    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    var midX = size.width / 2;
    var midY = size.height / 2;
    canvas.drawCircle(
        Offset((-pos.x * midX / 2) + midX, (pos.y * midY / 2) + midY),
        circleRadius,
        paint);
  }

  @override
  bool shouldRepaint(MazePainter old) => old.pos != pos;
}
