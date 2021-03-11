/*
 * Copyright 2020 Idan Ayalon. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

typedef Comparer<T> = bool Function(T left, T right);

typedef Hasher<T> = int Function(T value);

typedef Sorter<T> = int Function(T left, T right);

class EqualityComparer<T> {
  final Comparer<T> compare;
  final Hasher<T> hash;
  final Sorter<T> sort;

  EqualityComparer({
    Comparer<T>? comparer,
    Hasher<T>? hasher,
    Sorter<T>? sorter,
  })  : compare = comparer ?? _getDefaultComparer<T>(),
        hash = hasher ?? _getDefaultHasher<T>(),
        sort = sorter ?? _getDefaultSorter<T>();

  static Comparer<T> _getDefaultComparer<T>() =>
      (T left, T right) => left == right;

  static Hasher<T> _getDefaultHasher<T>() => (T value) => value.hashCode;

  static Sorter<T> _getDefaultSorter<T>() => (left, right) => 0;

  static EqualityComparer<T> forType<T>() => _registeredEqualityComparers[T] as EqualityComparer<T>;

  static final Map<Type, EqualityComparer> _registeredEqualityComparers = {
    dynamic: EqualityComparer<dynamic>(
      comparer: (left, right) => left == right,
      hasher: (value) => value.hashCode,
      sorter: (left, right) => 0,
    ),
    num: EqualityComparer<num>(
      comparer: (left, right) => left == right,
      hasher: (value) => value.hashCode,
      sorter: (left, right) => left.compareTo(right),
    ),
    int: EqualityComparer<int>(
      comparer: (left, right) => left == right,
      hasher: (value) => value.hashCode,
      sorter: (left, right) => left.compareTo(right),
    ),
    double: EqualityComparer<double>(
      comparer: (left, right) => left == right,
      hasher: (value) => value.hashCode,
      sorter: (left, right) => left.compareTo(right),
    ),
    String: EqualityComparer<String>(
      comparer: (left, right) => left == right,
      hasher: (value) => value.hashCode,
      sorter: (left, right) => left.compareTo(right),
    ),
    Duration: EqualityComparer<Duration>(
      comparer: (left, right) => left == right,
      hasher: (value) => value.hashCode,
      sorter: (left, right) => left.compareTo(right),
    ),
    BigInt: EqualityComparer<BigInt>(
      comparer: (left, right) => left == right,
      hasher: (value) => value.hashCode,
      sorter: (left, right) => left.compareTo(right),
    ),
  };

  static bool registerEqualityComparer<T>(EqualityComparer<T> comparer,
      {bool overwrite = false}) {
    var typeExists = _registeredEqualityComparers.containsKey(T);
    if (!typeExists || overwrite) _registeredEqualityComparers[T] = comparer;
    return typeExists;
  }

  /// [EqualityComparer.registerEqualityComparer].
  static EqualityComparer<T> unregisterEqualityComparer<T>() {
    return _registeredEqualityComparers.remove(T) as EqualityComparer<T>;
  }
}

abstract class OrderedIterable<T> extends Iterable<T> {
  Iterable<T> source;

  OrderedIterable(this.source);

  IterableSorter<T> getIterableSorter(IterableSorter<T> next);

  OrderedIterable<T> createOrderedIterable<TNewKey>(
      TNewKey Function(T) keySelector,
      EqualityComparer<TNewKey> keyComparer,
      bool descending) {
    final result = InternalOrderedIterable<T, TNewKey>(
        source, keySelector, keyComparer, descending);
    result.parent = this;
    return result;
  }
}

class InternalOrderedIterable<TValue, TKey> extends OrderedIterable<TValue> {
  OrderedIterable<TValue>? parent;
  TKey Function(TValue) keySelector;
  EqualityComparer<TKey> keyComparer;
  bool? descending;

  InternalOrderedIterable(Iterable<TValue> source, this.keySelector,
      this.keyComparer, this.descending)
      : super(source) {
    this.source = source;
  }

  @override
  Iterator<TValue> get iterator => iterate().iterator;

  Iterable<TValue> iterate() sync* {
    final buffer = source.toList();
    if (buffer.isNotEmpty) {
      final sorter = getIterableSorter(null);
      final map = sorter.sort(buffer, buffer.length);
      yield* OrderedBuffer(buffer, map);
    }
  }

  @override
  IterableSorter<TValue> getIterableSorter(IterableSorter<TValue>? next) {
    IterableSorter<TValue>? sorter = InternalIterableSorter<TValue, TKey>(
        keySelector, keyComparer, next,descending: descending);
    if (parent != null) sorter = parent!.getIterableSorter(sorter);
    return sorter;
  }
}

abstract class IterableSorter<T> {
  void computeKeys(List<T> elements, int count);

  int compareKeys(int idx1, int idx2);

  List<int> sort(List<T> elements, int count) {
    computeKeys(elements, count);
    final map = List<int>.generate(count, (i) => i, growable: false);
    quickSort(map, 0, count - 1);
    return map;
  }

  void quickSort(List<int> map, int left, int right) {
    do {
      var i = left;
      var j = right;
      final x = map[i + ((j - i) >> 1)];
      do {
        while (i < map.length && compareKeys(x, map[i]) > 0) {
          i++;
        }
        while (j >= 0 && compareKeys(x, map[j]) < 0) {
          j--;
        }
        if (i > j) break;
        if (i < j) {
          final temp = map[i];
          map[i] = map[j];
          map[j] = temp;
        }
        i++;
        j--;
      } while (i <= j);
      if (j - left <= right - i) {
        if (left < j) quickSort(map, left, j);
        left = i;
      } else {
        if (i < right) quickSort(map, i, right);
        right = j;
      }
    } while (left < right);
  }
}

class InternalIterableSorter<TValue, TKey> extends IterableSorter<TValue> {
  late TKey Function(TValue) keySelector;
  EqualityComparer<TKey>? comparer;
  bool? descending;
  IterableSorter<TValue>? next;
  late List<TKey> keys;

  InternalIterableSorter(
    this.keySelector,
    this.comparer,
    this.next, {
    this.descending = false,
  }) {
    comparer ??= EqualityComparer.forType<TKey>();
  }

  @override
  void computeKeys(List<TValue> elements, int count) {
    keys = List<TKey>.generate(count, (i) => keySelector(elements[i]));
    if (next != null) next!.computeKeys(elements, count);
  }

  @override
  int compareKeys(int index1, int index2) {
    final c = comparer?.sort(keys[index1], keys[index2]) ?? -1;
    if (c == 0) {
      if (next == null) return index1 - index2;
      return next!.compareKeys(index1, index2);
    }
    return descending! ? -c : c;
  }
}

class OrderedBuffer<T> extends Iterable<T> {
  List<T> data;
  List<int> orderedMap;

  OrderedBuffer(this.data, this.orderedMap);

  @override
  Iterator<T> get iterator => iterate().iterator;

  Iterable<T> iterate() sync* {
    for (var index in orderedMap) {
      yield data[index];
    }
  }
}
