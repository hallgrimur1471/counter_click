import 'package:counter_click/screens/authenticate/sign_in.dart';
import 'package:counter_click/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  String currentScreen = 'sign_in';

  void setScreen(String screen) {
    setState(() => currentScreen = screen);
  }

  @override
  Widget build(BuildContext context) {
    if (currentScreen == 'register') {
      return Register(
        setScreen: setScreen,
      );
    } else {
      return SignIn(setScreen: setScreen);
    }
  }
}
