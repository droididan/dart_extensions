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
import 'dart:collection';
import 'dart:math';

import 'package:dart_extensions/src/utils.dart';
import 'package:quiver/iterables.dart';

import 'data_stractures/stack.dart';
import 'equality.dart';

extension CollectionsExtensions<T> on Iterable<T> {
  

  ///Sorts elements in the array in-place according to natural sort order of the value returned by specified [selector] function.
  Iterable<T> sortBy<TKey>(
    TKey Function(T) keySelector, {
    EqualityComparer<TKey> keyComparer,
  }) {
    checkNullError(this);
    ArgumentError.checkNotNull(keySelector, 'keySelector');
    return InternalOrderedIterable(this, keySelector, keyComparer, false);
  }

  /// Returns `true` if at least one element matches the given [predicate].
  bool any(bool predicate(T element)) {
    if (this.isEmptyOrNull) return false;
    for (final element in this) if (predicate(element)) return true;
    return false;
  }

  /// Convert iterable to set
  Set<T> toMutableSet() => Set.from(this);

  /// Returns a set containing all elements that are contained
  /// by both this set and the specified collection.
  Set<T> intersect(Iterable other) {
    final set = this.toMutableSet();
    set.addAll(other);
    return set;
  }

  /// Groups the elements in values by the value returned by key.
  ///
  /// Returns a map from keys computed by key to a list of all values for which
  /// key returns that key. The values appear in the list in the same
  /// relative order as in values.
  Map<K, List<T>> groupBy<T, K>(K key(T e)) {
    var map = <K, List<T>>{};

    for (final element in this) {
      var list = map.putIfAbsent(key(element as T), () => []);
      list.add(element as T);
    }
    return map;
  }

  /// Returns a list containing only elements matching the given [predicate].
  List<T> filter(bool test(T element)) {
    final result = <T>[];
    forEach((e) {
      if (e != null && test(e)) {
        result.add(e);
      }
    });
    return result;
  }

  /// Returns a list containing all elements not matching the given [predicate] and will filter nulls as well.
  List<T> filterNot(bool test(T element)) {
    final result = <T>[];
    forEach((e) {
      if (e != null && !test(e)) {
        result.add(e);
      }
    });
    return result;
  }

// return the half size of a list
  int get halfLength => (this.length / 2).floor();

  /// Returns a list containing first [n] elements.
  List<T> takeOnly(int n) {
    if (n == 0) return [];

    var list = List<T>();
    var thisList = this.toList();
    if (this is Iterable) {
      final resultSize = this.length - n;
      if (resultSize <= 0) return [];
      if (resultSize == 1) return [this.last];

      List.generate(n, (index) {
        list.add(thisList[index]);
      });
    }
    return list;
  }

  /// Returns a list containing all elements except first [n] elements.
  List<T> drop(int n) {
    if (n == 0) return [];

    var list = List<T>();
    var originalList = this.toList();
    if (this is Iterable) {
      final resultSize = this.length - n;
      if (resultSize <= 0) return [];
      if (resultSize == 1) return [this.last];

      originalList.removeRange(0, n);

      originalList.forEach((element) => list.add(element));
    }
    return list;
  }

  // Retuns map operation as a List
   List<E> mapList<E>(E f(T e)) => this.map(f).toList();

  // Takes the first half of a list
  List<T> firstHalf() => take(halfLength).toList();

  // Takes the second half of a list
  List<T> secondHalf() => drop(halfLength).toList();

  /// returns a list with two swapped items
  /// [i] first item
  /// [j] second item
  List<T> swap(int i, int j) {
    final list = this.toList();
    final aux = list[i];
    list[i] = list[j];
    list[j] = aux;
    return list;
  }

  T getRandom() {
    Random generator = Random();
    final index = generator.nextInt(this.length);
    return this.toList()[index];
  }

  /// get the first element return null
  T get firstOrNull => _elementAtOrNull(0);

  T firstOrNullWhere(bool predicate(T element)) {
    return firstWhere(predicate, orElse: () => null);
  }

  /// get the last element if the list is not empty or return null
  T get lastOrNull => isNotEmpty ? last : null;

  T lastOrDefault(T defaultValue) => lastOrNull ?? defaultValue;

  /// get the first element or provider default
  /// example:
  /// var name = [danny, ronny, james].firstOrDefault["jack"]; // danny
  /// var name = [].firstOrDefault["jack"]; // jack
  T firstOrDefault(T defaultValue) => firstOrNull ?? defaultValue;

  ///
  /// Performs the given action on each element on iterable, providing sequential index with the element.
  /// [item] the element on the current iteration
  /// [index] the index of the current iteration
  ///
  /// example:
  /// ["a","b","c"].forEachIndexed((element, index) {
  ///    print("$element, $index");
  ///  });
  /// result:
  /// a, 0
  /// b, 1
  /// c, 2
  void forEachIndexed(void action(T element, int index)) {
    var index = 0;
    for (var element in this) {
      action(element, index++);
    }
  }

  /// Returns a new list with all elements sorted according to descending
  /// natural sort order.
  List<T> sortedDescending() {
    var list = toList();
    list.sort((a, b) => -(a as Comparable).compareTo(b));
    return list;
  }

  /// Checks if all elements in the specified [collection] are contained in
  /// this collection.
  bool containsAll(Iterable<T> collection) {
    for (var element in collection) {
      if (!contains(element)) return false;
    }
    return true;
  }

  /// Return a number of the existing elements by a specific predicate
  /// example:
  ///  final aboveTwenty = [
  ///    User(33, "chicko"),
  ///    User(45, "ronit"),
  ///    User(19, "amsalam"),
  ///  ].count((user) => user.age > 20); // 2
  int count([bool predicate(T element)]) {
    var count = 0;
    if (predicate == null) {
      return length;
    } else {
      for (var current in this) {
        if (predicate(current)) {
          count++;
        }
      }
    }

    return count;
  }

  /// Returns a list containing only the elements from given collection having distinct keys.
  ///
  /// Basically it's just like distinct function but with a predicate
  /// example:
  /// [
  ///    User(22, "Sasha"),
  ///    User(23, "Mika"),
  ///    User(23, "Miryam"),
  ///    User(30, "Josh"),
  ///    User(36, "Ran"),
  ///  ].distinctBy((u) => u.age).forEach((user) {
  ///    print("${user.age} ${user.name}");
  ///  });
  ///
  /// result:
  /// 22 Sasha
  /// 23 Mika
  /// 30 Josh
  /// 36 Ran
  List<T> distinctBy(predicate(T selector)) {
    final set = HashSet();
    final list = List<T>();
    toList().forEach((e) {
      final key = predicate(e);
      if (set.add(key)) {
        list.add(e);
      }
    });

    return list;
  }

// get an element at specific index or return null
  T _elementAtOrNull(int index) {
    return _elementOrNull(index, (_) => null);
  }

  _elementOrNull(int index, T defaultElement(int index)) {
// if our index is smaller then 0 return the default
    if (index < 0) return defaultElement(index);

    var counter = 0;
    for (var element in this) {
      if (index == counter++) {
        return element;
      }
    }

    return defaultElement(index);
  }

  /// Returns a set containing all elements that are contained by this collection
  /// and not contained by the specified collection.
  /// The returned set preserves the element iteration order of the original collection.
  ///
  /// example:
  ///
  /// [1,2,3,4,5,6].subtract([4,5,6])
  ///
  /// result:
  /// 1,2,3
  subtract(Iterable<T> other) {
    final set = toSet();
    set.removeAll(other);
    return set;
  }

  /// will convert iterable into a Stack data structure
  /// example:
  ///  [1,2,3,4].toStack()
  ///  stack.pop()
  ///  stack.push(5)
  ///
  StackX<T> toStack() {
    final stack = StackX<T>();
    stack.addAll(this);
    return stack;
  }

  bool get isEmptyOrNull => this == null || isEmpty;

  /// Zip is used to combine multiple iterables into a single list that contains
  /// the combination of them two.
  zip<T>(Iterable<T> iterable) sync* {
    if (iterable.isEmptyOrNull) return;
    final iterables = List<Iterable>()..add(this)..add(iterable);

    final iterators = iterables.map((e) => e.iterator).toList(growable: false);
    while (iterators.every((e) => e.moveNext())) {
      yield iterators.map((e) => e.current).toList(growable: false);
    }
  }

  /// Splits the Iterable into chunks of the specified size
  ///
  /// example:
  /// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].chunks(3))
  /// result:
  /// ([1, 2, 3], [4, 5, 6], [7, 8, 9], [10])
  Iterable<List<T>> chunks(int size) => partition(this, size);

  /// Return a list concatenates the output of the current list and another [iterable]
  List<T> concatWithSingleList(Iterable<T> iterable) {
    if (isEmptyOrNull || iterable.isEmptyOrNull) return [];

    return <T>[...this, ...iterable];
  }

  /// Return a list concatenates the output of the current list and multiple [iterables]
  List<T> concatWithMultipleList(List<Iterable<T>> iterables) {
    if (isEmptyOrNull || iterables.isEmptyOrNull) return [];
    final list = iterables.toList(growable: false).expand((i) => i);
    return <T>[...this, ...list];
  }

  /// Creates a Map instance in which the keys and values are computed from the iterable.
  Map<dynamic, dynamic> associate(key(element), value(element)) =>
      Map.fromIterable(this, key: key, value: value);

  /// Returns the first element matching the given [predicate], or `null`
  /// if element was not found.
  T find(predicate(T selector)) {
    for (final element in this) {
      if (predicate(element)) {
        return element;
      }
    }

    return null;
  }
}
