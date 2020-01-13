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

import 'data_stractures/stack.dart';

extension CollectionsExt<T> on Iterable<T> {
  // return the half size of a list
  int get halfLength => (this.length / 2).floor();

  /// Returns a list containing all elements except first [n] elements.
  List<T> take(int n) {
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

  List<T> firstHalf() => take(halfLength);

  List<T> secondHalf() => drop(halfLength);

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
  /// var name = [danny, ronny, idan].firstOrDefault["nuni"]; // danny
  /// var name = [].firstOrDefault["nuni"]; // nuni
  T firstOrDefault(T defaultValue) => firstOrNull ?? defaultValue;

  /// forEach with an index on collections, will provide [index] and [element] for every iteration,
  /// example:
  /// ["a","b","c"].forEachIndexed((item, index) {
  ///    print("$item, $index");
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
    for (var item in this) {
      final key = predicate(item);
      if (set.add(key)) {
        list.add(item);
      }
    }

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
    List<String>();
    final set = this.toSet();
    set.removeAll(other);
    return set;
  }

  /// will convert iterable into a Stack data structure
  /// example:
  ///  [1,2,3,4].toStack()
  ///  stack.pop()
  ///  stack.push(5)
  ///
  Stack<T> toStack() {
    final stack = Stack<T>();
    stack.addAll(this);
    return stack;
  }
}

class User {
  final int age;
  final String name;

  User(this.age, this.name);
}

main() {
  final arr = [1, 2, 3, 4, 5, 6, 7, 8];
  final numbers = arr.secondHalf();
//  user.forEach((u) => print(u));
  print(numbers);
}
