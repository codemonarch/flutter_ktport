import 'package:flutter/services.dart';

const posix = const MethodChannel('com.rarnu.flutter/routing');
route<T>(String name, dynamic arguments, void block(T obj)) async => block(await posix.invokeMethod<T>(name, arguments));
routeList<T>(String name, dynamic arguments, void block(List<T> list)) async => block(await posix.invokeListMethod<T>(name, arguments));
routeMap<K, V>(String name, dynamic arguments, void block(Map<K, V> map)) async => block(await posix.invokeMapMethod<K, V>(name, arguments));
routeObj<T>(String name, dynamic arguments, T parse(dynamic p), void block(T obj)) async => block(parse(await posix.invokeMethod(name, arguments)));
routeObjList<T>(String name, dynamic arguments, T parse(dynamic p), void block(List<T> list)) async => block((await posix.invokeListMethod(name, arguments)).map(parse).toList());
routeObjMap<K, V>(String name, dynamic arguments, V parse(dynamic p), void block(Map<K, V> map)) async => block((await posix.invokeMapMethod<K, dynamic>(name, arguments)).map((k, v) => MapEntry<K, V>(k, parse(v))));
