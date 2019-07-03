import 'package:ctw_flutter/theme.dart';
import 'package:flutter/material.dart';

class SuccessPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(50),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0, 1],
              colors: [
                successPopupGradient_1,
                successPopupGradient_2,
              ],
            )), child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Too easy!",
            style: Theme
                .of(context)
                .textTheme
                .display3,
          ),
          Stars(),
        ]));
  }
}

const starIcon = Icon(Icons.star);
const starOutlineIcon = Icon(Icons.star_border);

class Stars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          starIcon,
          starIcon,
          starIcon,
          starIcon,
          starIcon,
        ],
      ),
    );
  }
}
