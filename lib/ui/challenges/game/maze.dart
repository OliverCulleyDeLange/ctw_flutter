import 'dart:ui';

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


