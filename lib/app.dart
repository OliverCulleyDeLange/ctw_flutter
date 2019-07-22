import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/home.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cheat to win",
      theme: getTheme(),
      routes: {
        "/": (c) => Home(),
      },
    );
  }
}
