import 'dart:collection';

import 'string_extension.dart';

class KFList<E> extends ListBase<E> {

  // base
  List<E> _innerList = new List<E>();
  int get length => _innerList.length;
  set length(int length) => _innerList.length = length;
  void operator []= (int index, E value) =>  _innerList[index] = value;
  E operator [] (int index) => _innerList[index];

  // kotlin
  KFList<E> also(void block(KFList<E> list)) {
      block(this);
      return this;
  }
  R let<R>(R block(KFList<E> list)) => block(this);
  KFList<E> takeIf(bool block(KFList<E> list)) => block(this) ? this : null;
  KFList<E> takeUnless(bool block(KFList<E> list)) => !block(this) ? this : null;

  // contains/base
  // find
  // findLast
  // first/base
  // getOrElse
  // indexOf/base
  // indexOfFirst
  // indexOfLast
  // last/base
  // lastIndexOf/base
  // drop
  // dropLast
  // dropWhile
  // dropLastWhile
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
  // take/base
  // takeWhile/base
  // reversed
  // sortBy
  // sortByDescending
  // sorted
  // toOtherList(toXXXArray, ...)
  // groupBy
  // mapIndexed
  // mapIndexedNotNull
  // mapNotNull
  // distinct
  // distinctBy
  // all
  // any
  // count
  // forEach/base
  // forEachIndexed/new
  forEachIndexed(void action(int index, E element)) { for (int i = 0; i < this.length; i++) { action(i, this[i]); } }
  // none
  // reduce/base
  // reduceIndexed
  // plus
  // minus
  // plusElement
  // minusElement

  // joinTo/base
  // joinToString
  KFString joinToString([String sep = ","]) {
    var str = "";
    _innerList.forEach((it) => str += "$it$sep");
    if (str.endsWith(sep)) {
      str = str.substring(0, str.length - sep.length);
    }
    return KFString(str);
  }

  // map/override
  KFList<T> map<T>(T block(E obj)) => _iterableToKFList(super.map(block));
}

KFList<E> listOf<E> (List<E> list) => KFList<E>().also((it) => it.addAll(list));

KFList<T> _iterableToKFList<T>(Iterable<T> iter) => KFList<T>().also((it) => it.addAll(iter));

