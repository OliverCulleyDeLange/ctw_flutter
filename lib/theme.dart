import 'package:flutter/material.dart';

//Colors
var theme = Colors.deepOrange;
var typography = Typography.whiteMountainView;

var gradient1_1 = theme.shade50;
var gradient1_2 = theme.shade900;


ThemeData getTheme() {
  return ThemeData(
    primarySwatch: theme,
//      backgroundColor: Colors.white,
    canvasColor: theme.shade200,
//    primaryColor: primary,
//      primaryColorBrightness: Brightness.light,
//    accentColor: Colors.white,
//    accentColorBrightness: Brightness.dark,
//      scaffoldBackgroundColor: Colors.white,
//      bottomAppBarColor: Colors.pink,
    cardColor: theme.shade900,
//    dividerColor: Colors.black,
//    indicatorColor: primary,
//      iconTheme: IconThemeData(color: Colors.pink),
//      accentIconTheme: IconThemeData(color: Colors.purple),
//    primaryIconTheme: IconThemeData(color: primary),
//    appBarTheme: AppBarTheme(
//        color: Colors.white,
//        brightness: Brightness.light
//    ),
//      bottomAppBarTheme: BottomAppBarTheme(),
//    tabBarTheme: TabBarTheme(
//        labelColor: ???,
//        unselectedLabelColor: primary
//    ),
    textTheme: typography.copyWith(
      body1: typography.body1.copyWith(fontWeight: FontWeight.w300),
    ),
//    accentTextTheme: Typography.whiteMountainView.copyWith(
//      display2: TextStyle(fontWeight: FontWeight.w100),
//    ),
//    primaryTextTheme: Typography.blackMountainView.copyWith(
//    ),
//    buttonTheme: ButtonThemeData(
//        padding: ???,
//        minWidth: double.infinity,
//        colorScheme: ColorScheme.dark(
//            primary: primary,
//            primaryVariant: ???
//        )
//    ),
  );
}
