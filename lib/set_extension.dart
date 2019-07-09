import 'dart:collection';

import 'package:ktflutter/global_extension.dart';
import 'package:ktflutter/map_extension.dart';
import 'package:ktflutter/pair_extension.dart';

import 'package:ktflutter/string_extension.dart';

class KFSet<E> extends SetBase<E> {
  // base
  Set<E> _innerSet = new Set<E>();
  int get length => _innerSet.length;
  E lookup(Object element) => _innerSet.lookup(element);
  bool add(E value) => _innerSet.add(value);
  bool contains(Object element) => _innerSet.contains(element);
  bool remove(Object value) => _innerSet.remove(value);
  Iterator<E> get iterator => _innerSet.iterator;
  Set<E> toSet() => _innerSet.toSet();

  // kotlin
  KFSet<E> also(void block(KFSet<E> list)) {
    block(this);
    return this;
  }

  R let<R>(R block(KFSet<E> list)) => block(this);
  KFSet<E> takeIf(bool block(KFSet<E> list)) => block(this) ? this : null;
  KFSet<E> takeUnless(bool block(KFSet<E> list)) => !block(this) ? this : null;

  // find
  E find(bool block(E obj)) {
    for (var element in _innerSet) {
      if (block(element)) {
        return element;
      }
    }
    return null;
  }

  // findLast
  E findLast(bool block(E obj)) {
    for (int i = length - 1; i >= 0; i--) {
      if (block(_innerSet.elementAt(i))) {
        return _innerSet.elementAt(i);
      }
    }
    return null;
  }

  // indexOfFirst
  int indexOfFirst(bool block(E obj)) {
    var idx = -1;
    for (int i = 0; i < length; i++) {
      if (block(_innerSet.elementAt(i))) {
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
      if (block(_innerSet.elementAt(i))) {
        idx = i;
        break;
      }
    }
    return idx;
  }

  // drop
  KFSet<E> drop(int n) {
    var ret = KFSet<E>();
    for (int i = n; i < length; i++) {
      ret.add(_innerSet.elementAt(i));
    }
    return ret;
  }

  // dropLast
  KFSet<E> dropLast(int n) {
    var ret = KFSet<E>();
    for (int i = 0; i < length - n; i++) {
      ret.add(_innerSet.elementAt(i));
    }
    return ret;
  }

  // filter
  KFSet<E> filter(bool block(E obj)) {
    var ret = KFSet<E>();
    for (int i = 0; i < length; i++) {
      if (block(_innerSet.elementAt(i))) ret.add(_innerSet.elementAt(i));
    }
    return ret;
  }

  // filterIndexed
  KFSet<E> filterIndexed(bool block(int idx, E obj)) {
    var ret = KFSet<E>();
    for (int i = 0; i < length; i++) {
      if (block(i, _innerSet.elementAt(i))) ret.add(_innerSet.elementAt(i));
    }
    return ret;
  }

  // filterNot
  KFSet<E> filterNot(bool block(E obj)) {
    var ret = KFSet<E>();
    for (int i = 0; i < length; i++) {
      if (!block(_innerSet.elementAt(i))) ret.add(_innerSet.elementAt(i));
    }
    return ret;
  }

  // slice
  KFSet<E> slice(int startIdx, int endIdx) {
    var ret = KFSet<E>();
    for (int i = startIdx; i < endIdx; i++) {
      ret.add(_innerSet.elementAt(i));
    }
    return ret;
  }

  // sortBy
  KFSet<E> sortBy(int block(E first, E second)) =>
      klet<KFSet<E>, KFSet<E>>(setOf(_innerSet), (tmp) {
        tmp._innerSet.toList().sort(block);
        return tmp;
      });

  // sortByDescending
  KFSet<E> sortByDescending(int block(E first, E second)) =>
      klet<KFSet<E>, KFSet<E>>(setOf(_innerSet), (tmp) {
        tmp._innerSet.toList().sort(block);
        return setOf(tmp.toList().reversed);
      });

  // map/override
  KFSet<T> map<T>(T block(E obj)) =>
      KFSet<T>().also((it) => it.addAll(super.map(block)));

  // mapIndexed
  KFSet<T> mapIndexed<T>(T block(int idx, E obj)) {
    var ret = KFSet<T>();
    for (int i = 0; i < length; i++) {
      ret.add(block(i, _innerSet.elementAt(i)));
    }
    return ret;
  }

  // distinct
  KFSet<E> distinct() {
    var ret = KFSet<E>();
    for (var item in _innerSet) {
      if (!ret.contains(item)) {
        ret.add(item);
      }
    }
    return ret;
  }

  // distinctBy
  KFSet<E> distinctBy<K>(K block(E obj)) {
    var set = HashSet<K>();
    var list = KFSet<E>();
    for (var e in _innerSet) {
      var key = block(e);
      if (set.add(key)) {
        list.add(e);
      }
    }
    return list;
  }

  // all
  bool all(bool block(E obj)) {
    if (_innerSet.isEmpty) return false;
    for (var item in _innerSet) {
      if (!block(item)) {
        return false;
      }
    }
    return true;
  }

  // any
  bool any(bool block(E obj)) {
    if (_innerSet.isEmpty) return false;
    for (var item in _innerSet) {
      if (block(item)) {
        return true;
      }
    }
    return false;
  }

  // count
  int count(bool block(E obj)) {
    var ret = 0;
    for (var item in _innerSet) {
      if (block(item)) {
        ret++;
      }
    }
    return ret;
  }

  // forEachIndexed/new
  forEachIndexed(void action(int index, E element)) {
    for (int i = 0; i < this.length; i++) {
      action(i, this.elementAt(i));
    }
  }

  // none
  bool none(bool block(E obj)) {
    if (_innerSet.isEmpty) return true;
    for (var item in _innerSet) {
      if (block(item)) {
        return false;
      }
    }
    return true;
  }

  // reduceIndexed
  E reduceIndexed(E oper(int idx, E acc, E s)) {
    var accumulator = _innerSet.elementAt(0);
    for (int i = 1; i < length; i++) {
      accumulator = oper(i, accumulator, _innerSet.elementAt(i));
    }
    return accumulator;
  }

  // minus
  minus(Object obj) {
    var tmp = obj is List<E> ? obj : (obj is KFSet<E> ? obj._innerSet : null);
    _innerSet.removeWhere((it) => tmp.contains(it));
  }

  // joinToString
  KFString joinToString([String sep = ","]) {
    var str = "";
    _innerSet.forEach((it) => str += "$it$sep");
    if (str.endsWith(sep)) {
      str = str.substring(0, str.length - sep.length);
    }
    return KFString(str);
  }

  KFSet<String> toStringList() {
    var ret = KFSet<String>();
    for (var item in _innerSet) {
      ret.add("$item");
    }
    return ret;
  }

  KFMap<K, V> toMap<K, V>() {
    var ret = KFMap<K, V>();
    if (_innerSet is Set<KFPair<K, V>>) {
      for (var item in _innerSet) {
        var m = item as KFPair<K, V>;
        ret[m.left] = m.right;
      }
    }
    return ret;
  }

  // mapTo
  C mapTo<R, C extends Set<R>>(C dest, R block(E obj)) {
    for (var item in this) {
      dest.add(block(item));
    }
    return dest;
  }

  // mapIndexedTo
  C mapIndexedTo<R, C extends Set<R>>(C dest, R block(int idx, E obj)) {
    for (int i = 0; i < length; i++) {
      dest.add(block(i, _innerSet.elementAt(i)));
    }
    return dest;
  }

  // filterTo
  C filterTo<C extends Set<E>>(C dest, bool block(E obj)) {
    for (var item in this) {
      if (block(item)) {
        dest.add(item);
      }
    }
    return dest;
  }

  // filterIndexedTo
  C filterIndexedTo<C extends Set<E>>(C dest, bool block(int idx, E obj)) {
    for (int i = 0; i < length; i++) {
      if (block(i, _innerSet.elementAt(i))) {
        dest.add(_innerSet.elementAt(i));
      }
    }
    return dest;
  }

  // filterNotTo
  C filterNotTo<C extends Set<E>>(C dest, bool block(E obj)) {
    for (var item in this) {
      if (!block(item)) {
        dest.add(item);
      }
    }
    return dest;
  }
}

KFSet<E> setOf<E>(Iterable<E> set) => KFSet<E>().also((it) => it.addAll(set));
