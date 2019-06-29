import 'package:ctw_flutter/challenges.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 4,
        children: List.generate(challenges.length, (index) {
          return InkWell(
              onTap: () async {
                var won = await Navigator.pushNamed(context, "$index");
                print("Challenge result: $won");
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
