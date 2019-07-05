import 'package:flutter_test/flutter_test.dart';
import 'package:ktflutter/list_extension.dart';
import 'package:ktflutter/map_extension.dart';
import 'package:ktflutter/pair_extension.dart';
import 'package:ktflutter/string_extension.dart';

void main() {
    test('adds one to input values', () {
        var a = listOf([KFPair("a", 1), KFPair("b", 2), KFPair("c", 3)]);
        var b = a.toMap<String, int>();
        b.forEach((k, v) => print("k = $k, v = $v"));
        b.add({"d": 4, "e": 5});
        print("-----");
        b.forEach((k, v) => print("k = $k, v = $v"));
        print("-----");
        b.minus({"c": 3});
        b.forEach((k, v) => print("k = $k, v = $v"));
        print("-----");

        var xx = listOf(["a", "b", "c"]);
        xx.minus(["b"]);
        xx.forEach(print);


    });

}
