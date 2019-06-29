import 'package:ctw_flutter/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cheat to win", // Unhelpful - better name?
      theme: getTheme(),
      home: Scaffold(
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
        crossAxisCount: 5,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return Card(
            child: Text(
              index.toString(),
              style: Theme
                  .of(context)
                  .textTheme
                  .body1,
            ),
          );
        }));
  }
}
