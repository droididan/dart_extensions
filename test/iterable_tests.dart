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
import 'package:dart_extensions/src/iterable.dart';
import 'package:dart_extensions/src/model/user.dart';
import 'package:test/test.dart';

main() {
  final users = [User(22, "Ronit"), User(23, "Ronit"), User(22, "Oded"), User(32, "Shimi")];

  group('iterables', () {
    test('mapList', () {
      expect([3,4,5,6,7].mapList((item) => item.toDouble()), [3.0, 4.0, 5.0, 6.0, 7.0]);
    });

    test('any', () {
      expect(users.any((u) => u.name == 'Oded'), true);
      expect(users.any((u) => u.name == 'Not Exists'), false);
      expect([].any((u) => u.name == 'Oded'), false);
    });

    test('filter', () {
      [null, 1, 2].where((n) => n == 2);
      final listWithNull = [null, User(1, "r"), User(2, "t")];
      final numberList = [1, 2, 3, 4, 5, 6];

      expect(users.filter((u) => u.name == "Ronit"), [users[0], users[1]]);
      expect(numberList.filter((n) => n > 4), [5, 6]);
      expect(listWithNull.filter((u) => u.name == "r"), [listWithNull[1]]);
    });

    test('filterNot', () {
      final listWithNull = [null, User(1, "r"), User(2, "t")];
      final numberList = [1, 2, 3, 4, 5, 6];

      expect(listWithNull.filterNot((u) => u.name == "t"), [listWithNull[1]]);
      expect(numberList.filterNot((n) => n > 4), [1, 2, 3, 4]);
    });

    test('takeOnly', () {
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
      expect(users.count((u) => u.name == "Ronit"), 2);
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
      expect([1, 2, 3, 4].concatWithSingleList([5, 6, 7, 8, 9, 10, 11]), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
      expect([1, 2, 3, 4].concatWithSingleList([]), []);
      expect([].concatWithSingleList([5, 6, 7, 8, 9, 10, 11]), []);
    });

    test('concatWithMultipleList', () {
      final listOfLists = [
        [5, 6, 7],
        [8, 9, 10]
      ];
      expect([1, 2, 3, 4].concatWithMultipleList(listOfLists), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      expect([1, 2, 3, 4].concatWithMultipleList([[], []]), [1, 2, 3, 4]);
      expect([].concatWithMultipleList(listOfLists), []);
    });

    test('zip', () {
      final expectedResult = [
        [1, 2],
        [3, 4],
        [5, 6]
      ];
      expect([1, 3, 5].zip([2, 4, 6]), expectedResult);
      expect([1, 3, 5].zip([2, 4, 6, 7, 8]), expectedResult);
    });

    test('associate', () {
      final users = [User(33, "Miki"), User(45, "Anna"), User(19, "Amit")];
      expect(users.associate((k) => k.name, (e) => e.age), {'Miki': 33, 'Anna': 45, 'Amit': 19});
    });

    test('find', () {
      final users = [User(22, "Ronit"), User(23, "Ronit"), User(22, "Oded"), User(32, "Shimi")];
      expect(users.find((u) => u.name == "Ronit"), users.first);
      expect(users.find((u) => u.name == "Oded"), users[2]);
      expect(users.find((u) => u.name == "Not Exists Name"), null);
      expect(users.find((u) => u.age == 32), users.last);
      expect(users.find((u) => u.age == 31), null);
    });

    test('gruopBy by age', () {
      final expected = {
        22: [users[0], users[2]],
        23: [users[1]],
        32: [users[3]]
      };

      expect(users.groupBy((u) => u.age), expected);
    });

    test('gourpBy by name', () {
      final expected = {
        'Ronit': [users[0], users[1]],
        'Oded': [users[2]],
        'Shimi': [users[3]]
      };
      expect(users.groupBy((u) => u.name), expected);
    });

    test('toMutableSet', () {
      expect([1, 1, 1, 1, 2, 3, 4].toMutableSet(), [1, 2, 3, 4]);
      expect(["a", "b", "a"].toMutableSet(), ["a", "b"]);
    });

    test('intersect', () {
      expect(Set.from([1, 2, 3, 4]).intersect(Set.from([3, 4, 5, 6])), [1, 2, 3, 4, 5, 6]);
      expect(Set.from([-1, -2, -3, 4]).intersect(Set.from([3, 4, 5, 6])), [-1, -2, -3, 4, 3, 5, 6]);
    });
  });
}
