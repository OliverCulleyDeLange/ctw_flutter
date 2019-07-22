import 'package:flutter/material.dart';

class ColourAnimatedTile extends StatefulWidget {
  final Function buildChild;

  final bool animate;

  ColourAnimatedTile({this.buildChild, this.animate});

  @override
  _ColourAnimatedTileState createState() => _ColourAnimatedTileState();
}

class _ColourAnimatedTileState extends State<ColourAnimatedTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorTween;

  animate() {
    _controller.forward();
  }

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
    if (widget.animate) {
      _controller.forward();
    }
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) {
        return Card(
            color: _colorTween.value,
            child: widget.buildChild(animate)
        );
      },
    );
  }
}
