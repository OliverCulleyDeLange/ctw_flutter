import 'package:flutter/material.dart';

class SuccessPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(50),
        alignment: Alignment.bottomCenter,
        color: Colors.pink,
        child: Text("Too easy!"));
  }
}
