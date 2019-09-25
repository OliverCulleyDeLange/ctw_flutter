import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Spring extends StatelessWidget {
  Widget build(BuildContext context) {
    return Magnets(
      child: Icon(
        FontAwesomeIcons.magnet,
        color: Colors.blue,
        size: 100,
      ),
    );
  }
}

// Tutorial on physics animations
// https://flutter.dev/docs/cookbook/animation/physics-simulation#complete-example

/// A draggable card that moves back to [Alignment.center] when it's
/// released.
class Magnets extends StatefulWidget {
  final Widget child;

  Magnets({this.child});

  @override
  _MagnetsState createState() => _MagnetsState();
}

class _MagnetsState extends State<Magnets> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  /// The alignment of the card as it is dragged or being animated.
  ///
  /// While the card is being dragged, this value is set to the values computed
  /// in the GestureDetector onPanUpdate callback. If the animation is running,
  /// this value is set to the value of the [_animation].
  Alignment _dragAlignment = Alignment.bottomCenter;

  Animation<Alignment> _animation;

  double _scale = 1;
  double _previousScale = 1;
  Vector3 _translate = Vector3(0.0, 0.0, 0.0);
  Vector3 _previousTranslate = Vector3(0.0, 0.0, 0.0);
  double _rotate = 0;
  double _previousRotation = 0;

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.bottomCenter,
      ),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onScaleStart: (details) {
//        debugPrint("onScaleStart $details");
        _controller.stop();
        setState(() {
          _previousTranslate = Vector3(
            details.focalPoint.dx - (size.width / 2),
            details.focalPoint.dy - (size.height / 2),
            0.0,
          );
        });
      },
      onScaleUpdate: (details) {
        setState(() {
          _rotate += details.rotation - _previousRotation;
          _previousRotation = details.rotation;

          _scale += details.scale - _previousScale;
          _previousScale = details.scale;

          var _pos = Vector3(
            details.focalPoint.dx - (size.width / 2),
            details.focalPoint.dy - (size.height / 2),
            0.0,
          );
          var _delta = _pos - _previousTranslate;
          debugPrint("$_delta");
          _translate += _delta;
          _previousTranslate = _pos;

//          debugPrint(
//              "rotate: $_rotate, scale: $_scale, translate: $_translate");
        });
      },
      onScaleEnd: (details) {
//        debugPrint("onScaleEnd $details");
        _runAnimation(details.velocity.pixelsPerSecond, size);
        setState(() {
          _previousRotation = 0;
          _previousScale = 1;
        });
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.translation(_translate)
          ..rotateZ(_rotate)
          ..scale(_scale, _scale, 0.0),
        transformHitTests: true,
        child: widget.child,
      ),
    );
  }
}
