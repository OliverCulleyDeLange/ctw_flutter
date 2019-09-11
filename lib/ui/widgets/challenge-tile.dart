import 'package:flutter/material.dart';

class ChallengeTile extends StatefulWidget {
  final bool completed;
  final Widget challengeScreen;
  final String text;

  ChallengeTile({this.completed, this.challengeScreen, this.text});

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
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _colorTween = ColorTween(
      begin: Colors.deepOrange,
      end: Colors.green,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.completed) {
      _controller.forward();
    }
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) {
        return Card(
            color: _colorTween.value,
            child: InkWell(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (c) => widget.challengeScreen));
                },
                child: Text(
                  widget.text,
                  style: Theme
                      .of(context)
                      .textTheme
                      .display2,
                )));
      },
    );
  }
}
