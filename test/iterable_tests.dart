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
import 'package:test/test.dart';
import 'package:dart_extensions/iterable.dart';

main() {
  final users = <User>[]
    ..add(User(22, "Ronit"))
    ..add(User(22, "Oded"))
    ..add(User(32, "Shimi"));

  group('iterables', () {
    test('take', () {
      expect([1, 2, 3, 4].takeOnly(1), [1]);
      expect([1, 2, 3, 4].takeOnly(2), [1, 2]);
      expect([1, 2, 3, 4].takeOnly(10), []);
    });

    test('drop', () {
      expect([1, 2, 3, 4].drop(1), [2, 3, 4]);
      expect([1, 2, 3, 4].drop(2), [3, 4]);
      expect([1, 2, 3, 4].drop(5), []);
    });

    test('firstHalf', () {
      expect([1, 2, 3, 4].firstHalf(), [1, 2]);
    });

    test('secondHalf', () {
      expect([1, 2, 3, 4].secondHalf(), [3, 4]);
    });

    test('swap', () {
      expect([1, 2, 3, 4].swap(0, 1), [2, 1, 3, 4]);
    });

    test('lastOrDefault', () {
      expect([1, 2, 3, 4].lastOrDefault(999), 4);
      expect([].lastOrDefault(999), 999);
    });

    test('firstOrDefault', () {
      expect([1, 2, 3, 4].firstOrDefault(999), 1);
      expect([].firstOrDefault(999), 999);
    });

    test('sortedDescending', () {
      expect([1, 2, 3, 4].sortedDescending(), [4, 3, 2, 1]);
    });

    test('containsAll', () {
      expect([1, 2, 3, 4].containsAll([1, 2, 5]), false);
      expect([1, 2, 3, 4].containsAll([1, 2, 4]), true);
      expect([].containsAll([1, 2, 4]), false);
    });

    test('containsAll', () {
      expect([1, 2, 3, 4].containsAll([1, 2, 5]), false);
      expect([1, 2, 3, 4].containsAll([1, 2, 4]), true);
      expect([].containsAll([1, 2, 4]), false);
    });

    test('containsAll', () {
      expect(users.count((u) => u.age == 22), 2);
      expect(users.count((u) => u.name == "Ronit"), 1);
      expect(users.count((u) => u.name == "Bin"), 0);
    });

    test('distinctBy', () {
      final expected = users.distinctBy((u) => u.age);
      expect(users.distinctBy((u) => u.age), expected);
    });

    test('subtract', () {
      expect([1, 2, 3, 4].subtract([3, 4]), [1, 2]);
      expect([1, 2, 3, 4].subtract([1, 2, 3, 4]), []);
      expect([1, 2, 3, 4].subtract([1, 2]), [3, 4]);
    });

    test('toStack', () {
      var stack = [1, 2, 3, 4].toStack();
      expect(stack.pop(), 4);
      expect(stack.top(), 3);
      expect(stack.pop(), 3);
      expect(stack.top(), 2);
    });

    test('concatWithSingleList', () {
      expect([1, 2, 3, 4].concatWithSingleList([33333, 44444]),
          [1, 2, 3, 4, 33333, 44444]);
      expect([1, 2, 3, 4].concatWithSingleList([]), []);
      expect([].concatWithSingleList([33333, 44444]), []);
    });

    test('concatWithSingleList', () {
      final listOfLists = [
        [111, 222],
        [333, 444]
      ];
      expect([1, 2, 3, 4].concatWithMultipleList(listOfLists),
          [1, 2, 3, 4, 111, 222, 333, 444]);
      expect([1, 2, 3, 4].concatWithMultipleList([[],[]]), [1,2,3,4]);
      expect([].concatWithMultipleList(listOfLists), []);
    });
  });
}

class User {
  final int age;
  final String name;

  User(this.age, this.name);

  @override
  String toString() {
    return "$age, $name";
  }
}
