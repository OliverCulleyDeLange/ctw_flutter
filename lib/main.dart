import 'package:ctw_flutter/router.dart';
import 'package:ctw_flutter/screens/home.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cheat to win",
      theme: getTheme(),
      onGenerateRoute: generateRoute,
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}