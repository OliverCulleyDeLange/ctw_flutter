import 'package:ctw_flutter/challenges.dart';
import 'package:ctw_flutter/screens/widgets/challenge-tile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 4,
        children: List.generate(challenges.length, (index) =>
            ChallengeTile(index)
        ));
  }
}

