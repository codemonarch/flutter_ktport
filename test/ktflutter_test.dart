import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ktflutter/list_extension.dart';
import 'package:ktflutter/map_extension.dart';
import 'package:ktflutter/pair_extension.dart';
import 'package:ktflutter/set_extension.dart';
import 'package:ktflutter/string_extension.dart';

void main() {
    test('adds one to input values', () {
        var list = ['two', 'one', 'three', 'four'];
        list.sort((a, b) => a.length.compareTo(b.length));
        list.forEach(print);
    });
}
