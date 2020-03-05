import 'package:ctw_flutter/ui/challenges/base-challenge.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth extends StatefulWidget {
  @override
  _LocalAuthState createState() => _LocalAuthState();
}

class _LocalAuthState extends State<LocalAuth> {
  bool canCheckBiometrics = false;

  doAuth(context) async {
    bool authd = await LocalAuthentication()
        .authenticateWithBiometrics(localizedReason: "");
    if (authd) {
      BaseChallenge.of(context).complete();
    }
  }

  void _setCanDoBiometrics() async {
    var _canCheckBiometrics = await LocalAuthentication().canCheckBiometrics;
    setState(() {
      canCheckBiometrics = _canCheckBiometrics;
    });
  }

  @override
  void initState() {
    super.initState();
    _setCanDoBiometrics();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
          child: GestureDetector(
            onTap: () => doAuth(context),
            child: canCheckBiometrics
                ? Icon(Icons.fingerprint)
                : Icon(Icons.vpn_key),
          ));
  }
}
