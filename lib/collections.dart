import 'dart:typed_data';

import 'package:collection/collection.dart';

export 'package:collection/collection.dart';

mixin CollectionX {}

extension IterableUIntX on Iterable<int> {
  Uint8List toUInt8List() => Uint8List.fromList(toList());
}

extension IterableEqX on Iterable? {
  bool deepEquals(Object? other) => const DeepCollectionEquality().equals(this, other);
}

extension MacEqX on Map? {
  bool deepEquals(Object? other) => const DeepCollectionEquality().equals(this, other);
}

extension IterableX<E> on Iterable<E> {
  List<T> mapNotNull<T>(T? Function(E e) f) {
    final List<T> res = [];
    for (final e in this) {
      final r = f(e);
      if (r != null) res.add(r);
    }
    return res;
  }

  UnmodifiableListView<E> toUnmodifiableList() => UnmodifiableListView(this);

  UnmodifiableSetView<E> toUnmodifiableSet() => UnmodifiableSetView(toSet());

  int get lastIndex => length == 0 ? throw RangeError('Cannot find the last index of an empty iterable') : length - 1;

  num? maxByOrNull(num Function(E e) f) {
    if (isEmpty) return null;
    num max = f(first);
    for (final element in this) {
      final val = f(element);
      if (val > max) max = val;
    }
    return max;
  }

  num? minByOrNull(num Function(E e) f) {
    if (isEmpty) return null;
    num min = f(first);
    for (final element in this) {
      final val = f(element);
      if (val < min) min = val;
    }
    return min;
  }

  E? getOrNull(int index) {
    if (index >= length || index < 0) return null;
    return elementAt(index);
  }
}

extension IterableMapX<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> get asMap => Map.fromEntries(this);

  UnmodifiableMapView<K, V> get asUnmodifiableMap => Map.fromEntries(this).toUnmodifiable();
}

extension ListX<E> on List<E> {
  UnmodifiableListView<E> toUnmodifiable() => UnmodifiableListView(this);
}

extension SetX<E> on Set<E> {
  UnmodifiableSetView<E> toUnmodifiable() => UnmodifiableSetView(this);
}

extension MapX<K, V> on Map<K, V> {
  UnmodifiableMapView<K, V> toUnmodifiable() => UnmodifiableMapView(this);

  Map<K2, V> mapKeys<K2, V2>(K2 Function(K key, V value) convert) {
    final Map<K2, V> res = {};
    for (final entry in entries) {
      final converted = convert(entry.key, entry.value);
      res[converted] = entry.value;
    }
    return res;
  }

  Map<K2, V> mapKeysNotNull<K2, V2>(K2? Function(K key, V value) convert) {
    final Map<K2, V> res = {};
    for (final entry in entries) {
      final converted = convert(entry.key, entry.value);
      if (converted == null) continue;
      res[converted] = entry.value;
    }
    return res;
  }

  Map<K, V2> mapValues<K2, V2>(V2 Function(K key, V value) convert) {
    final Map<K, V2> res = {};
    for (final entry in entries) {
      final converted = convert(entry.key, entry.value);
      res[entry.key] = converted;
    }
    return res;
  }

  Map<K, V2> mapValuesNotNull<K2, V2>(V2? Function(K key, V value) convert) {
    final Map<K, V2> res = {};
    for (final entry in entries) {
      final converted = convert(entry.key, entry.value);
      if (converted == null) continue;
      res[entry.key] = converted;
    }
    return res;
  }

  Map<K2, V2> mapNotNull<K2, V2>(MapEntry<K2, V2>? Function(K key, V value) convert) {
    final Map<K2, V2> res = {};
    for (final entry in entries) {
      final converted = convert(entry.key, entry.value);
      if (converted == null) continue;
      res[converted.key] = converted.value;
    }
    return res;
  }

  void sortByKeys() {
    final List<K> mKeys = [...keys];
    mKeys.sort();

    final Map<K, V> temp = {}..addAll(this);
    clear();

    for (final k in mKeys) {
      addAll({k: temp[k] as V});
    }
  }
}

extension UnmodifiableListX<E> on UnmodifiableListView<E> {
  UnmodifiableListView<E> modifiedCopy(
    List<E> Function(List<E> initial) modifier,
  ) {
    return modifier.call(toList()).toUnmodifiable();
  }
}

extension UnmodifiableSetX<E> on UnmodifiableSetView<E> {
  UnmodifiableSetView<E> modifiedCopy(
    Set<E> Function(Set<E> initial) modifier,
  ) {
    return modifier.call(toSet()).toUnmodifiable();
  }
}

extension UnmodifiableMapX<K, V> on UnmodifiableMapView<K, V> {
  UnmodifiableMapView<K, V> modifiedCopy(
    Map<K, V> Function(Map<K, V> initial) modifier,
  ) {
    return modifier.call(Map.from(this)).toUnmodifiable();
  }
}
