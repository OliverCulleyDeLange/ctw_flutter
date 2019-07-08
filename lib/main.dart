import 'package:ctw_flutter/domain/home-models.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/home.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(RestartWidget(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cheat to win",
      theme: getTheme(),
      home: Scaffold(
        body: ChangeNotifierProvider(
          builder: (context) => HomeModel(),
          child: Home(),
        ),
      ),
    );
  }
}
