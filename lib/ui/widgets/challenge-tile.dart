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
    with TickerProviderStateMixin {
  AnimationController _colorController;
  Animation<Color> _colorTween;
  AnimationController _tapController;
  Animation<double> _tapAnimation;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _colorTween = ColorTween(
      begin: Colors.deepOrange,
      end: Colors.green,
    ).animate(_colorController);

    _tapController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => widget.challengeScreen))
              .whenComplete(() {
            _tapController.reverse();
          });
        }
      });
    _tapAnimation = Tween<double>(begin: 1, end: 0.5).animate(CurvedAnimation(
      parent: _tapController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.bounceIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.completed) {
      _colorController.forward();
    }
    return ScaleTransition(
      scale: _tapAnimation,
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) {
          return Card(
              color: _colorTween.value,
              child: InkWell(
                  onTap: () async {
                    _tapController.forward();
                  },
                  child: Text(
                    widget.text,
                    style: Theme
                        .of(context)
                        .textTheme
                        .display2,
                  )));
        },
      ),
    );
  }
}
