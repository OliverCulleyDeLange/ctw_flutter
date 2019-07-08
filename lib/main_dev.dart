import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

import 'main.dart';

void main() {
  Stetho.initialize();
  runApp(RestartWidget(child: MyApp()));
}
