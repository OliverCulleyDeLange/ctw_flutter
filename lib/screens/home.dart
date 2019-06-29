import 'package:ctw_flutter/challenges.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 5,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(challenges.length, (index) {
          return InkWell(
              onTap: () {
                Navigator.pushNamed(context, "$index");
              },
              child: Card(
                child: Text(
                  index.toString(),
                  style: Theme.of(context).textTheme.body1,
                ),
              ));
        }));
  }
}
