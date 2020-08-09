import 'package:counter_click/shared/loading.dart';
import 'package:counter_click/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function setScreen;

  SignIn({this.setScreen});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0.0,
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.person, color: Colors.white),
                    label: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      widget.setScreen("register");
                    },
                  )
                ]),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Sign in to Tournament clicker',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'You must enter an email' : null,
                      decoration: InputDecoration(
                        hintText: 'Enter an email',
                        fillColor: Colors.white24,
                        filled: true,
                      ),
                      initialValue: email,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        fillColor: Colors.white24,
                        filled: true,
                      ),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.white24,
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                            email,
                            password,
                          );
                          if (result == null) {
                            // TODO: improve error value, is email badly formatted?
                            // do username and password not match?
                            setState(() {
                              error = 'Sign in failed. ' +
                                  'Make sure you sign in with a registered ' +
                                  'Tournament clicker account.';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
