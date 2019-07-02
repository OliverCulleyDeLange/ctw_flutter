import 'package:ctw_flutter/challenges.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _colorTween = ColorTween(
      begin: Colors.deepOrange,
      end: Colors.green,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 4,
        children: List.generate(challenges.length, (index) {
          return InkWell(
              onTap: () async {
                var won = await Navigator.pushNamed(context, "$index");
                print("Challenge result: $won");
                if (_controller.status == AnimationStatus.completed) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
              },
              child: AnimatedBuilder(
                animation: _colorTween,
                builder: (context, child) {
                  return Card(
                    color: _colorTween.value,
                    child: Text(
                      index.toString(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                    ),
                  );
                },
              ));
        }));
  }
}
