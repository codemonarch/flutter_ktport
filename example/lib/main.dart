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

class SizedProgress extends SizedBox {
    SizedProgress({
        Key key,
        double width = 300.0,
        double height = 16.0,
        double value = 0.0
    }): super(
        key: key,
        width: width,
        height: height,
        child: Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: LinearProgressIndicator(
                value: value,
            ),
        )
    );
}

class _HomePageState extends State<HomePage> {

    File _imgFile;
    bool _isDownloading = false;
    double _progress = 0;

    _HomePageState(): super() {
        deviceFilePath((path) {
            _imgFile = File("$path/sample.jpg");
            print("imgFile => ${_imgFile.path}");
        });
    }

    List<Widget> _makeWidgets() {
        var ret = <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(0, 16.0, 0, 8.0),
                child: Text('Running on: 23333\n'),
            ),
            SizedButon(
                title: "Device Method Test",
                onPressed: _testDeviceMethods,
            ),
            SizedButon(
                title: "Download Test",
                onPressed: _testDownload,
            ),
            SizedButon(
                title: "Delete Download File",
                onPressed: _testDeleteDownloadFile),
            SizedButon(
                title: 'Toast Test',
                onPressed: _testToast,
            ),
            SizedButon(
                title: 'String Test',
                onPressed: _testString,
            ),
            SizedButon(
                title: 'Route Test',
                onPressed: _testRoute,
            ),
        ];
        if (_isDownloading) {
            ret.add(SizedProgress(
                value: _progress,
            ));
        }
        if (_imgFile != null && _imgFile.existsSync()) {
            ret.add(Image.file(_imgFile, width: 300, height: 200, fit: BoxFit.fill,));
        }
        return ret;
    }

    _testDeviceMethods() {
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
    }
    _testDownload() {
        var imageurl = "https://n1image.hjfile.cn/zhuanti/2019/07/08/bb6fa594eaa236b1a567a68cc0c3e1b0.jpg";
        // var imageurl = 'https://n1image.hjfile.cn/hjclass/public/upload/201712/8697783b-253e-4e2a-aecb-bd1561c35667.jpg';
        deviceFilePath((path) {
            _imgFile = File("$path/sample.jpg");
            download(imageurl, _imgFile.path, (state, position, filesize, error) => setState(() {
                switch(state) {
                    case DownloadState.Start:
                        _isDownloading = true;
                        _progress = 0;
                        break;
                    case DownloadState.Progress:
                        _progress = (position / filesize);
                        break;
                    case DownloadState.Complete:
                        _isDownloading = false;
                        break;
                    case DownloadState.Error:
                        _isDownloading = false;
                        break;
                }
            }));
        });
    }

    _testDeleteDownloadFile() {
        if (_imgFile.existsSync()) {
            _imgFile.deleteSync();
            setState(() {});
        }
    }

    _testToast() {
        toast(context, "6666");
    }
    _testString() {
        var str = stringOf("abcdefg");
        var enc = str.base64encode();
        var dec = enc.base64decode();
        print("encoded => $enc");
        print("decoded => $dec");
    }
    _testRoute() {
        route<String>("hello", { 'name': 'rarnu'}, (it) => print(it));
    }

    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
                children: _makeWidgets()
            ),
        ),
    );
}
