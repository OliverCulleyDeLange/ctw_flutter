import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../base-challenge.dart';

class Sortable {
  Sortable(this.icon, this.sortGroup, this.sorted);

  IconData icon;
  String sortGroup;
  bool sorted;
}

class Sort extends StatefulWidget {
  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<Sort> {
  List<Sortable> sortables;

  @override
  void initState() {
    var isAndroid = Platform.isAndroid;
    sortables = [
      Sortable(FontAwesomeIcons.sun, "green", false),
      Sortable(FontAwesomeIcons.cloudShowersHeavy, "red", false),
      Sortable(FontAwesomeIcons.laugh, "green", false),
      Sortable(FontAwesomeIcons.angry, "red", false),
      Sortable(FontAwesomeIcons.spider, "red", false),
      Sortable(FontAwesomeIcons.cat, "green", false),
      Sortable(FontAwesomeIcons.android, isAndroid ? "green" : "red", false),
      Sortable(FontAwesomeIcons.apple, isAndroid ? "red" : "green", false),
    ];
  }

  getDragTarget(String sortGroup, Color color) {
    return DragTarget<Sortable>(onAccept: (data) {
      setState(() {
        data.sorted = true;
      });
      if (sortables.every((s) => s.sorted)) {
        BaseChallenge.of(context).complete();
      }
    }, onWillAccept: (data) {
      return data.sortGroup == sortGroup;
    }, builder: (context, candidateData, rejectedData) {
      return Container(
        height: 200,
        color: color,
        child: GridView.count(
            crossAxisCount: 2,
            children: sortables
                .where((s) => s.sorted && s.sortGroup == sortGroup)
                .map((s) => Icon(s.icon))
                .toList()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: getDragTarget("green", Colors.green),
          ),
          Expanded(
            child: getDragTarget("red", Colors.red),
          )
        ],
      ),
      Flexible(
        fit: FlexFit.tight,
        child: GridView.count(
          crossAxisCount: 5,
          children: sortables
              .where((e) => !e.sorted)
              .map((Sortable s) => Draggable<Sortable>(
                    data: s,
                    child: Icon(s.icon),
                    feedback: Icon(s.icon),
                  ))
              .toList(),
        ),
      ),
    ]);
  }
}
