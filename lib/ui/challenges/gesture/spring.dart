import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:gesturable/gesturable.dart';
import 'package:vector_math/vector_math_64.dart';

class Spring extends StatefulWidget {
  @override
  _SpringState createState() => _SpringState();
}

class _SpringState extends State<Spring> {
  Vector3 _offset;
  double _rotate;
  double _scale;

  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
      Positioned(
        top: 0,
        child: RotatedBox(
          child: SvgPicture.asset(
            'assets/img/magnet.svg',
            height: 200,
            alignment: Alignment.topCenter,
          ),
          quarterTurns: 2,
        ),
      ),
//      Movable(
//          snapTo: Alignment(0.0, -0.5),
//          onMove: (offset, scale, rotate) {
//            _offset = offset;
//            _scale = scale;
//            _rotate = rotate;
//          },
//          shouldSnap: (velocity) {
//            return false;
//          },
//          child: SvgPicture.asset(
//            'assets/img/magnet.svg',
//          )),
    ]);
  }
}
