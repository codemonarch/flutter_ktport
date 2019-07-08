import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ktflutter/download_extension.dart';
import 'package:ktflutter/global_extension.dart';
import 'package:ktflutter/route_extension.dart';
import 'package:ktflutter/string_extension.dart';
import 'package:ktflutter/toast_extension.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
    Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
        ),
        home: HomePage(),
    );
}

class HomePage extends StatefulWidget {
    _HomePageState createState() => _HomePageState();
}

class SizedButon extends SizedBox {
    SizedButon({
        Key key,
        double width = 300.0,
        double height = 42.0,
        String title = "",
        @required VoidCallback onPressed
    }) : super(
        key: key,
        width: width,
        height: height,
        child: Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: RaisedButton(
                child: Text(title),
                onPressed: onPressed,
            ),
        )
    );
}

class _HomePageState extends State<HomePage> {

    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
                children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 16.0, 0, 8.0),
                        child: Text('Running on: 23333\n'),
                    ),

                    SizedButon(title: "Device Method Test", onPressed: () {
                        platform((it) => print("platform => $it"));
                        appVersionCode((it) => print("appVersionCode => $it"));
                        appVersionName((it) => print("appVersionName => $it"));
                        deviceVersion((it) => print("deviceVersion => $it"));
                        deviceModel((it) => print("deviceModel => $it"));
                        deviceId((it) => print("deviceId => $it"));
                        appBundle((b) => print("bundle => $b"));
                        appPackage((p) => print("package => $p"));
                        // paths
                        deviceDocumentPath((path) => print("document => $path"));
                        deviceFilePath((path) => print("file => $path"));
                        deviceCachePath((path) => print("cache => $path"));
                        // android only
                        deviceExternalPath((path) => print("sdcard => $path"));
                        deviceExternalDocumentPath((path) => print("sdcard_document => $path"));
                        deviceExternalFilePath((path) => print("sdcard_file=> $path"));
                        deviceExternalCachePath((path) => print("sdcard_cache=> $path"));
                        deviceObbPath((path) => print("obb=> $path"));
                    },),

                    SizedButon(title: "Download Test", onPressed: (){
                        var imageurl = 'https://n1image.hjfile.cn/hjclass/public/upload/201712/8697783b-253e-4e2a-aecb-bd1561c35667.jpg';
                        deviceFilePath((path) {
                            var savePath = "$path/${stringOf(imageurl).lastPathComponent()}";
                            print("download_path => $savePath");
                            download(imageurl, savePath, (state, position, filesize, error) {
                                if (state == DownloadState.Complete) {
                                    print("download_completed => $savePath");
                                    var f = File(savePath);
                                    print("file_exists => ${f.existsSync()}");
                                }
                            });
                        });
                    },),
                    SizedButon(title: 'Toast Test', onPressed: () {
                        toast(context, "6666");
                    },),
                    SizedButon(title: 'String Test', onPressed: () {
                        var str = stringOf("abcdefg");
                        var enc = str.base64encode();
                        var dec = enc.base64decode();
                        print("encoded => $enc");
                        print("decoded => $dec");
                    },),
                    SizedButon(title: 'Route Test', onPressed: () {
                        route<String>("hello", { 'name': 'rarnu'}, (it) => print(it));
                    },),
                ],
            ),
        ),
    );
}
