import 'package:flutter/material.dart';
import 'package:ktflutter/route_extension.dart';
import 'package:ktflutter/global_extension.dart';
import 'package:ktflutter/toast_extension.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
    Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blue,
        ),
        home: HomePage(),
    );
}

class HomePage extends StatefulWidget {
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text('Plugin example app',
                style: TextStyle(color: Colors.white),
            ),
        ),
        body: Center(
            child: Column(
                children: <Widget>[
                    Text('Running on: 23333\n'),
                    RaisedButton(child:
                        Text("Click"),
                        onPressed: () {
                            platform((it) => print("platform => $it"));
                            appVersionCode((it) => print("appVersionCode => $it"));
                            appVersionName((it) => print("appVersionName => $it"));
                            deviceVersion((it) => print("deviceVersion => $it"));
                            deviceModel((it) => print("deviceModel => $it"));
                            deviceId((it) => print("deviceId => $it"));
                            appBundle((b) => print("bundle => $b"));
                            appPackage((p) => print("package => $p"));
                            route<String>("hello", { 'name': 'rarnu' }, (it) => print(it));
                            toast(context, "6666");
                        }
                    ),
                ],
            ),
        ),
    );
}
