import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ktflutter/list_extension.dart';
import 'package:ktflutter/map_extension.dart';
import 'package:ktflutter/pair_extension.dart';
import 'package:ktflutter/regex_extension.dart';
import 'package:ktflutter/set_extension.dart';
import 'package:ktflutter/string_extension.dart';

void main() {
    test('reg', () {
        var str = "rarnu1985gmail.com";
        var ret = isEmail(str);
        print("regTest: ret => $ret");
    });
}
