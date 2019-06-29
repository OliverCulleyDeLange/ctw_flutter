import 'package:ctw_flutter/theme.dart';
import 'package:flutter/material.dart';

class Challenge1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new Challenge1State();
}

class Challenge1State extends State<Challenge1> {
  @override
  Widget build(BuildContext context) {
    // Override status bar color to white (as bg is blue)
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // Box decoration takes a gradient
                gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0, 1],
              colors: [
                gradient1_1,
                gradient1_2,
              ],
            )),
            child: Text("Challenge")));
  }
}
