import 'package:flutter/material.dart';

class Maze extends StatefulWidget {
  @override
  _MazeState createState() => _MazeState();
}

class _MazeState extends State<Maze> with SingleTickerProviderStateMixin {
  AnimationController _animation;

  @override
  void initState() {
    _animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animation.repeat();
  }

  @override
  Widget build(BuildContext context) {
//    return RotationTransition(
//      child:
    return CustomPaint(
      size: Size.infinite,
      painter: MazePainter(),
    ); //,
//      turns: _animation,
//    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

class MazePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlueAccent[400]
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(MazePainter old) => false;
}
