import 'dart:collection';

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


}

KFMap<K, V> mapOf<K, V> (Map<K, V> map) => KFMap<K, V>().also((it) => it.addAll(map));
