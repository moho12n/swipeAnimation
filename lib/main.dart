import 'dart:async';

import 'package:bringtoforeground/bringtoforeground.dart';
import 'package:bringtoforeground_example/swipeAnim.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimize_app/minimize_app.dart';

void main() => runApp(MyApp());

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Swipe(),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Foreground(),
    );
  }
}

class Foreground extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Foreground> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      Timer.periodic(Duration(seconds: 8), (t) {
        print("bringAppToForeground");
        Bringtoforeground.bringAppToForeground();
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  elevation: 6,
                  child: Text("view swipe animation"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyApp2()),
                    );
                  }),
              RaisedButton(
                onPressed: () {
                  print("Bring app To Background");
                  MinimizeApp.minimizeApp();
                },
                child: Text("Bring to Backgrounnd"),
              ),
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
