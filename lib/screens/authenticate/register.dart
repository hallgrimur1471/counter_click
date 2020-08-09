import 'package:counter_click/shared/loading.dart';
import 'package:counter_click/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function setScreen;

  Register({this.setScreen});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final _auth = AuthService();
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
                    color: Colors.black,
                    icon: Icon(Icons.person, color: Colors.white),
                    label: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      widget.setScreen("sign_in");
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
                      'Register to Tournament clicker',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter an email',
                        fillColor: Colors.white24,
                        filled: true,
                      ),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      initialValue: email,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter a password',
                        fillColor: Colors.white24,
                        filled: true,
                      ),
                      validator: (val) => val.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.white24,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        setState(() => loading = true);
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                            email,
                            password,
                          );
                          if (result == null) {
                            setState(() {
                              error = 'Registration failed.\n' +
                                  'Make sure you supply a valid email address.';
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
