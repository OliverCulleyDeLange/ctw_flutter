import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/home.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics());
    return MaterialApp(
      title: "Cheat to win",
      theme: getTheme(),
      routes: {
        "/": (c) => Home(),
      },
      navigatorObservers: <NavigatorObserver>[observer],
    );
  }
}
