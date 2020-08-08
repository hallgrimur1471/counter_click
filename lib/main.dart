import 'package:counter_click/models/user.dart';
import 'package:counter_click/screens/auth_listener.dart';
import 'package:counter_click/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Counter click',
        home: AuthWrapper(),
      ),
    );
    // return MaterialApp(
    //   title: 'Counter click',
    //   theme: ThemeData(
    //     primarySwatch: Colors.indigo,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   home: MyHomePage(title: 'Counter click'),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Text(
                        "Decrement",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _decrementCounter();
                  },
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Text(
                        "Increment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _incrementCounter();
                  },
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$_counter',
                  style: TextStyle(color: Colors.white, fontSize: 120),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

class ScaffoldContextButton extends StatelessWidget {
  const ScaffoldContextButton({this.onPressedCallback});

  final Function onPressedCallback;

  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                "Nice!",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              heightFactor: 2,
            ),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 1),
          ),
        );
        onPressedCallback();
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
