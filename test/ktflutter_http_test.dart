import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ktflutter/http_extension.dart';

void main() {
    test('http GET', () async {
        await testGET();
    });

    test('http POST', () async {
        await testPOST();
    });

    test('http HEAD', () async {
        await testHEAD();
    });

    test('http PUT', () async {
        await testPUT();
    });

    test('http DELETE', () async {
        await testDELETE();
    });
}

Future<dynamic> testGET() async {
    return httpGet(
        'https://api.douban.com/v2/movie/top250?start=0&count=1&apikey=0b2bdeda43b5688921839c8ecb20399b',
    ).then((HttpResponse response) {
        print(response);
    }).catchError((error) {
        print(error);
    });
}

Future<dynamic> testPOST() async {
    return httpPost(
        'https://api.douban.com/v2/movie/top250?start=0&count=1&apikey=0b2bdeda43b5688921839c8ecb20399b', 
        body: jsonEncode({
            'platform': 'app',
            'array': [12345],
        }),
    ).then((HttpResponse response) {
        print(response);
    }).catchError((error) {
        print(error);
    });
}

Future<dynamic> testHEAD() async {
    return http(
        'https://api.douban.com/v2/movie/top250?start=0&count=1&apikey=0b2bdeda43b5688921839c8ecb20399b',
        HttpMethod.HEAD,
    ).then((HttpResponse response) {
        print(response);
    }).catchError((error) {
        print(error);
    });
}

Future<dynamic> testPUT() async {
    return http(
        'https://api.douban.com/v2/movie/top250?start=0&count=1&apikey=0b2bdeda43b5688921839c8ecb20399b',
        HttpMethod.PUT,
    ).then((HttpResponse response) {
        print(response);
    }).catchError((error) {
        print(error);
    });
}

Future<dynamic> testDELETE() async {
    return http(
        'https://api.douban.com/v2/movie/top250?start=0&count=1&apikey=0b2bdeda43b5688921839c8ecb20399b',
        HttpMethod.DELETE,
    ).then((HttpResponse response) {
        print(response);
    }).catchError((error) {
        print(error);
    });
}