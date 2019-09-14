import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'maze/maze-world.dart';

class MazeChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MazeGame().widget;
  }
}

class MazeGame extends BaseGame {
  MazeWorld mazeWorld = MazeWorld();

  MazeGame() {
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
  }

  @override
  void update(double t) {}
}
