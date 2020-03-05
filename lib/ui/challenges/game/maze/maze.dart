import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'maze-world.dart';

class MazeChallenge extends StatefulWidget {
  @override
  _MazeChallengeState createState() => _MazeChallengeState();
}

class _MazeChallengeState extends State<MazeChallenge> {
  @override
  Widget build(BuildContext context) {
    return MazeGame(context).widget;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }
}

class MazeGame extends BaseGame {
  MazeWorld mazeWorld;

  MazeGame(BuildContext context) {
    mazeWorld = MazeWorld(context);
    mazeWorld.initializeWorld();
    add(Bg());
    add(mazeWorld);
  }

  @override
  void onAttach() {
    debugPrint("Game attach");
  }

  @override
  void onDetach() {
    debugPrint("Game detatch");
    mazeWorld.destroyWorld(); //cleanup
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    debugPrint("Game state now: $state");
  }
}

class Bg extends PositionComponent {
  final paint = Paint()
    ..color = Colors.red[400]
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;

  @override
  void render(Canvas canvas) {
    prepareCanvas(canvas);
    canvas.drawPath(
        Path()
          ..lineTo(width, 0)..lineTo(width, height)..lineTo(0, height)..lineTo(
            0, 0),
        paint);
  }

  @override
  void resize(Size size) {
    width = size.width;
    height = size.height;
//    debugPrint("BG vw: ${width}, vh: ${height}");
  }

  @override
  void update(double t) {}
}
