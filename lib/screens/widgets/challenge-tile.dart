import 'package:flutter/material.dart';

class ChallengeTile extends StatefulWidget {
  final index;

  ChallengeTile(this.index);

  @override
  _ChallengeTileState createState() => _ChallengeTileState();
}

class _ChallengeTileState extends State<ChallengeTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _colorTween = ColorTween(
      begin: Colors.deepOrange,
      end: Colors.green,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          var won = await Navigator.pushNamed(context, "${widget.index}");
          print("Challenge result: $won");
          _controller.forward();
        },
        child: AnimatedBuilder(
          animation: _colorTween,
          builder: (context, child) {
            return Card(
              color: _colorTween.value,
              child: Text(
                widget.index.toString(),
                style: Theme
                    .of(context)
                    .textTheme
                    .display2,
              ),
            );
          },
        ));
  }
}
