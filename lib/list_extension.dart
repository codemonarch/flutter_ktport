import 'dart:collection';

import 'package:ktflutter/global_extension.dart';
import 'package:ktflutter/map_extension.dart';
import 'package:ktflutter/pair_extension.dart';

import 'package:ktflutter/string_extension.dart';

class KFList<E> extends ListBase<E> {
  // base
  List<E> _innerList = new List<E>();
  int get length => _innerList.length;
  set length(int length) => _innerList.length = length;
  operator []=(int index, E value) => _innerList[index] = value;
  E operator [](int index) => _innerList[index];
  List<E> toFlutterList() => _innerList;

  // kotlin
  KFList<E> also(void block(KFList<E> list)) {
    block(this);
    return this;
  }

  R let<R>(R block(KFList<E> list)) => block(this);
  KFList<E> takeIf(bool block(KFList<E> list)) => block(this) ? this : null;
  KFList<E> takeUnless(bool block(KFList<E> list)) =>
      !block(this) ? this : null;

  // find
  E find(bool block(E obj)) {
    for (var element in _innerList) {
      if (block(element)) {
        return element;
      }
    }
    return null;
  }

  // findLast
  E findLast(bool block(E obj)) {
    for (int i = length - 1; i >= 0; i--) {
      if (block(_innerList[i])) {
        return _innerList[i];
      }
    }
    return null;
  }

  // indexOfFirst
  int indexOfFirst(bool block(E obj)) {
    var idx = -1;
    for (int i = 0; i < length; i++) {
      if (block(_innerList[i])) {
        idx = i;
        break;
      }
    }
    return idx;
  }

  // indexOfLast
  int indexOfLast(bool block(E obj)) {
    var idx = -1;
    for (int i = length - 1; i >= 0; i--) {
      if (block(_innerList[i])) {
        idx = i;
        break;
      }
    }
    return idx;
  }

  // drop
  KFList<E> drop(int n) {
    var ret = KFList<E>();
    for (int i = n; i < length; i++) {
      ret.add(_innerList[i]);
    }
    return ret;
  }

  // dropLast
  KFList<E> dropLast(int n) {
    var ret = KFList<E>();
    for (int i = 0; i < length - n; i++) {
      ret.add(_innerList[i]);
    }
    return ret;
  }

  // filter
  KFList<E> filter(bool block(E obj)) {
    var ret = KFList<E>();
    for (int i = 0; i < length; i++) {
      if (block(_innerList[i])) ret.add(_innerList[i]);
    }
    return ret;
  }

  // filterIndexed
  KFList<E> filterIndexed(bool block(int idx, E obj)) {
    var ret = KFList<E>();
    for (int i = 0; i < length; i++) {
      if (block(i, _innerList[i])) ret.add(_innerList[i]);
    }
    return ret;
  }

  // filterNot
  KFList<E> filterNot(bool block(E obj)) {
    var ret = KFList<E>();
    for (int i = 0; i < length; i++) {
      if (!block(_innerList[i])) ret.add(_innerList[i]);
    }
    return ret;
  }

  // slice
  KFList<E> slice(int startIdx, int endIdx) =>
      listOf(_innerList.sublist(startIdx, endIdx));

  // sortBy
  KFList<E> sortBy(int block(E first, E second)) =>
      klet<KFList<E>, KFList<E>>(listOf(_innerList), (tmp) {
        tmp._innerList.sort(block);
        return listOf(tmp);
      });

  // sortByDescending
  KFList<E> sortByDescending(int block(E first, E second)) =>
      klet<KFList<E>, KFList<E>>(listOf(_innerList), (tmp) {
        tmp._innerList.sort(block);
        return listOf(tmp.reversed.toList());
      });

  // map/override
  KFList<T> map<T>(T block(E obj)) =>
      KFList<T>().also((it) => it.addAll(super.map(block)));

  // mapIndexed
  KFList<T> mapIndexed<T>(T block(int idx, E obj)) {
    var ret = KFList<T>();
    for (int i = 0; i < length; i++) {
      ret.add(block(i, _innerList[i]));
    }
    return ret;
  }

  // distinct
  KFList<E> distinct() {
    var ret = KFList<E>();
    for (var item in _innerList) {
      if (!ret.contains(item)) {
        ret.add(item);
      }
    }
    return ret;
  }

  // distinctBy
  KFList<E> distinctBy<K>(K block(E obj)) {
    var set = HashSet<K>();
    var list = KFList<E>();
    for (var e in _innerList) {
      var key = block(e);
      if (set.add(key)) {
        list.add(e);
      }
    }
    return list;
  }

  // all
  bool all(bool block(E obj)) {
    if (_innerList.isEmpty) return false;
    for (var item in _innerList) {
      if (!block(item)) {
        return false;
      }
    }
    return true;
  }

  // any
  bool any(bool block(E obj)) {
    if (_innerList.isEmpty) return false;
    for (var item in _innerList) {
      if (block(item)) {
        return true;
      }
    }
    return false;
  }

  // count
  int count(bool block(E obj)) {
    var ret = 0;
    for (var item in _innerList) {
      if (block(item)) {
        ret++;
      }
    }
    return ret;
  }

  // forEachIndexed/new
  forEachIndexed(void action(int index, E element)) {
    for (int i = 0; i < this.length; i++) {
      action(i, this[i]);
    }
  }

  // none
  bool none(bool block(E obj)) {
    if (_innerList.isEmpty) return true;
    for (var item in _innerList) {
      if (block(item)) {
        return false;
      }
    }
    return true;
  }

  // reduceIndexed
  E reduceIndexed(E oper(int idx, E acc, E s)) {
    var accumulator = _innerList[0];
    for (int i = 1; i < length; i++) {
      accumulator = oper(i, accumulator, _innerList[i]);
    }
    return accumulator;
  }

  // minus
  minus(Object obj) {
    var tmp = obj is List<E> ? obj : (obj is KFList<E> ? obj._innerList : null);
    _innerList.removeWhere((it) => tmp.contains(it));
  }

  // joinToString
  KFString joinToString([String sep = ","]) {
    var str = "";
    _innerList.forEach((it) => str += "$it$sep");
    if (str.endsWith(sep)) {
      str = str.substring(0, str.length - sep.length);
    }
    return KFString(str);
  }

  KFList<String> toStringList() {
    var ret = KFList<String>();
    for (var item in _innerList) {
      ret.add("$item");
    }
    return ret;
  }

  KFMap<K, V> toMap<K, V>() {
    var ret = KFMap<K, V>();
    if (_innerList is List<KFPair<K, V>>) {
      for (var item in _innerList) {
        var m = item as KFPair<K, V>;
        ret[m.left] = m.right;
      }
    }
    return ret;
  }

  // mapTo
  C mapTo<R, C extends List<R>>(C dest, R block(E obj)) {
    for (var item in this) {
      dest.add(block(item));
    }
    return dest;
  }

  // mapIndexedTo
  C mapIndexedTo<R, C extends List<R>>(C dest, R block(int idx, E obj)) {
    for (int i = 0; i < length; i++) {
      dest.add(block(i, _innerList[i]));
    }
    return dest;
  }

  // filterTo
  C filterTo<C extends List<E>>(C dest, bool block(E obj)) {
    for (var item in this) {
      if (block(item)) {
        dest.add(item);
      }
    }
    return dest;
  }

  // filterIndexedTo
  C filterIndexedTo<C extends List<E>>(C dest, bool block(int idx, E obj)) {
    for (int i = 0; i < length; i++) {
      if (block(i, _innerList[i])) {
        dest.add(_innerList[i]);
      }
    }
    return dest;
  }

  // filterNotTo
  C filterNotTo<C extends List<E>>(C dest, bool block(E obj)) {
    for (var item in this) {
      if (!block(item)) {
        dest.add(item);
      }
    }
    return dest;
  }
}

KFList<E> listOf<E>(Iterable<E> list) =>
    KFList<E>().also((it) => it.addAll(list));
