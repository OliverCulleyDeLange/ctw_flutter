import 'package:ctw_flutter/bloc/challenge-bloc.dart';
import 'package:ctw_flutter/domain/home-models.dart';
import 'package:ctw_flutter/theme.dart';
import 'package:ctw_flutter/ui/home.dart';
import 'package:ctw_flutter/ui/widgets/restart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(GlobalProviders());

class GlobalProviders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: <SingleChildCloneableWidget>[
      ChangeNotifierProvider(
        builder: (context) {
          debugPrint("Building HomeViewModel");
          return HomeViewModel();
        },
      ),
      Provider(
        builder: (context) {
          debugPrint("Building ChallengeProgressBloc");
          return ChallengeProgressBloc();
        },
        dispose: (context, ChallengeProgressBloc bloc) => bloc?.dispose(),
      ),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
        child: MaterialApp(
          title: "Cheat to win",
          theme: getTheme(),
          home: Scaffold(
            body: Home(),
          ),
        ));
  }
}
