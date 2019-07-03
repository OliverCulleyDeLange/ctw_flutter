import 'package:flutter/material.dart';

//Colors
var theme = Colors.deepOrange;
var typography = Typography.whiteMountainView;

var backgroundGradient_1 = theme.shade200;
var backgroundGradient_2 = theme.shade900;

var successPopupGradient_1 = theme.shade900;
var successPopupGradient_2 = theme.shade600;


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
    iconTheme: IconThemeData(color: Colors.white70),
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
      display2: typography.display2.copyWith(fontWeight: FontWeight.w200),
      display3: typography.display3.copyWith(fontWeight: FontWeight.w200),
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
