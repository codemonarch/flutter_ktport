
import 'dart:io';

import 'package:ktflutter/string_extension.dart';

enum DownloadState { Start, Progress, Complete, Error }

typedef DownloadCallback = void Function(DownloadState state, int position, int filesize, String error);


Future<bool> download(String url, String localFile, DownloadCallback callback) async {

    File fTmp = File(localFile);
    if (fTmp.existsSync()) {
        fTmp.deleteSync();
    }
    String strFolder = stringOf(localFile).substringBeforeLast('/').toString();
    Directory fFolder = Directory(strFolder);
    if (!fFolder.existsSync()) {
        fFolder.createSync(recursive: true);    
    }

    var isDownloadSuccess = true;
    try {
        HttpClient client = HttpClient();
        client.connectionTimeout = Duration(seconds: 5);
        
        HttpClientRequest request = await client.getUrl(Uri.parse(url));
        HttpClientResponse response = await request.close();
        int filesize = response.contentLength;

        if (callback != null) callback(DownloadState.Start, 0, filesize, null);

        File fileOut = File('$localFile.tmp');
        if (fileOut.existsSync()) {
            fileOut.deleteSync();
        }

        int position = 0;
        response.listen((data) {
            int count = data.length;
            fileOut.writeAsBytesSync(data);
            position += count;
            if (callback != null) callback(DownloadState.Progress, position, filesize, null);
        }, onDone: () {
            fileOut.renameSync(localFile);
            callback(DownloadState.Complete, 0, filesize, null);
        }, onError: (error) {
            isDownloadSuccess = false;
            if (callback != null) callback(DownloadState.Error, 0, 0, error.toString());
        }, cancelOnError: true);

    } on Error catch (error) {
        print(error);
        isDownloadSuccess = false;
        if (callback != null) callback(DownloadState.Error, 0, 0, error.toString());
    } on Exception catch (exception) {
        print(exception);
        isDownloadSuccess = false;
        if (callback != null) callback(DownloadState.Error, 0, 0, exception.toString());
    }
    if (!isDownloadSuccess) {
        await fTmp.delete();
    }
    return isDownloadSuccess;
}