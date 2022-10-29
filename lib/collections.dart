import 'dart:typed_data';

import 'package:collection/collection.dart';

export 'package:collection/collection.dart';

mixin CollectionX {}

extension IterableUIntX on Iterable<int> {
  UnmodifiableUint8ListView toUnmodifiableUInt8List() => UnmodifiableUint8ListView(Uint8List.fromList(toList()));
}

extension IterableX<E> on Iterable<E> {
  Iterable<T> mapNotNull<T>(T? Function(E e) f) {
    return map(f).where((element) => element != null).cast();
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

  E? getOrNull(int index) {
    if (index >= length || index < 0) return null;
    return elementAt(index);
  }
}

extension ListX<E> on List<E> {
  UnmodifiableListView<E> toUnmodifiable() => UnmodifiableListView(this);
}

extension SetX<E> on Set<E> {
  UnmodifiableSetView<E> toUnmodifiable() => UnmodifiableSetView(this);
}

extension MapX<K, V> on Map<K, V> {
  UnmodifiableMapView<K, V> toUnmodifiable() => UnmodifiableMapView(this);

  Map<K2, V2> mapNotNull<K2, V2>(MapEntry<K2, V2>? Function(K key, V value) convert) {
    final Map<K2, V2> res = {};
    forEach((key, value) {
      final converted = convert(key, value);
      if (converted != null) res[converted.key] = converted.value;
    });
    return res;
  }

  void sortByKeys() {
    final List<K> _keys = [...keys.toList()];
    _keys.sort();

    final Map<K, V> temp = {}..addAll(this);
    clear();

    for (final k in _keys) {
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
