import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

import 'app.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}
