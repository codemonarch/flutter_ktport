import 'dart:collection';

import 'package:ktflutter/list_extension.dart';
import 'package:ktflutter/pair_extension.dart';

class KFMap<K, V> extends MapBase<K, V> {

    // base
    Map<K, V> _innerMap = new Map<K, V>();
    V operator [](Object key) => _innerMap[key];
    void operator []=(K key, V value) => _innerMap[key] = value;
    void clear() => _innerMap.clear();
    Iterable<K> get keys => _innerMap.keys;
    V remove(Object key) => _innerMap.remove(key);

    // kotlin
    KFMap<K, V> also(void block(KFMap<K, V> map)) {
        block(this);
        return this;
    }
    R let<R>(R block(KFMap<K, V> list)) => block(this);
    KFMap<K, V> takeIf(bool block(KFMap<K, V> list)) => block(this) ? this : null;
    KFMap<K, V> takeUnless(bool block(KFMap<K, V> list)) => !block(this) ? this : null;

    // toList()
    KFList<KFPair<K, V>> toList() {
        var ret = KFList<KFPair<K, V>>();
        _innerMap.forEach((k, v) => ret.add(KFPair(k, v)));
        return ret;
    }

    // mapToList
    KFList<R> mapToList<R>(R block(MapEntry<K, V> e)) {
        var ret = KFList<R>();
        _innerMap.forEach((k, v) => ret.add(block(MapEntry(k, v))));
        return ret;
    }

    // forEachEntry
    forEachEntry(void block(MapEntry<K, V> e)) => _innerMap.forEach((k, v) => block(MapEntry(k, v)));

    // all
    bool all(bool block(MapEntry<K, V> e)) {
        if (_innerMap.isEmpty) return false;
        var ret = true;
        forEachEntry((it) { if (!block(it)) ret = false; });
        return ret;
    }

    // public inline fun <K, V> Map<out K, V>.any(predicate: (Map.Entry<K, V>) -> Boolean): Boolean
    bool any(bool block(MapEntry<K, V> e)) {
        if (_innerMap.isEmpty) return false;
        var ret = false;
        forEachEntry((it) { if (block(it)) ret = true; });
        return ret;
    }

    // count
    int count(bool block(MapEntry<K, V> e)) {
        var ret = 0;
        forEachEntry((it) { if (block(it)) ret++; });
        return ret;
    }

    // none
    bool none(bool block(MapEntry<K, V> e)) {
        if (_innerMap.isEmpty) return true;
        var ret = true;
        forEachEntry((it) { if (block(it)) ret = false; });
        return ret;
    }

    // filterKeys
    KFMap<K, V> filterKeys(bool block(K k)) {
        var ret = KFMap<K, V>();
        forEachEntry((it) {if (block(it.key)) ret[it.key] = it.value; });
        return ret;
    }

    // filterValues
    KFMap<K, V> filterValues(bool block(V v)) {
        var ret = KFMap<K, V>();
        forEachEntry((it) {if (block(it.value)) ret[it.key] = it.value; });
        return ret;
    }

    // filter
    KFMap<K, V> filter(bool block(MapEntry<K, V> e)) {
        var ret = KFMap<K, V>();
        forEachEntry((it) {if (block(it)) ret[it.key] = it.value; });
        return ret;
    }

    // filterNot
    KFMap<K, V> filterNot(bool block(MapEntry<K, V> e)) {
        var ret = KFMap<K, V>();
        forEachEntry((it) {if (!block(it)) ret[it.key] = it.value; });
        return ret;
    }

    // add
    add(Object obj) {
        var tmp = obj is Map<K, V> ? obj : (obj is KFMap<K, V> ? obj._innerMap : null);
        tmp.forEach((k, v) => _innerMap[k] = v);
    }

    // minus
    minus(Object obj) {
        var tmp = obj is Map<K, V> ? obj : (obj is KFMap<K, V> ? obj._innerMap : null);
        _innerMap.removeWhere((k, v) => tmp[k] == v);
    }

}

KFMap<K, V> mapOf<K, V>(Map<K, V> map) => KFMap<K, V>().also((it) => it.addAll(map));
