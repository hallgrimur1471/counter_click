import 'package:counter_click/models/user.dart';
import 'package:counter_click/screens/authenticate/authenticate.dart';
import 'package:counter_click/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
