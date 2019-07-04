import 'package:flutter_test/flutter_test.dart';
import 'package:ktflutter/list_extension.dart';
import 'package:ktflutter/map_extension.dart';
import 'package:ktflutter/string_extension.dart';

void main() {
  	test('adds one to input values', () {
    	var a = listOf([1,2,3]);
    	var m = mapOf({"a":"apple","b":"blue","c":"color","1":"true"});
    	var s = stringOf("abcd\n\nefga\n\nbcde\n\nfg");
  		print(s);
  		print("==============");
  		var ss = s.skipEmptyLine();
  		print(ss);
  	});
}
