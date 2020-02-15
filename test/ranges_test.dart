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
import 'package:dart_extensions/src/ranges.dart';
import 'package:test/test.dart';

main() {
  group('ranges', () {
    test('test positive range', () {
      expect(1.until(-10), []);
    });

    test('test from positive to nagative  range', () {
      expect(1.until(-3, step: -1), [1, 0, -1, -2]);
    });

    test('test positive range with step 2', () {
      expect(1.until(10, step: 2), [1, 3, 5, 7, 9]);
    });

    test('test negative range', () {
      expect((-10).until(0), [-10, -9, -8, -7, -6, -5, -4, -3, -2, -1]);
    });

    test('test positive range with step 2', () {
      expect((-10).until(0, step: 2), [-10, -8, -6, -4, -2]);
    });

    test('for loop', () {
      final numbers = <int>[];
      for (final num in 1.until(10)) {
        numbers.add(num);
      }
      expect(numbers, [1, 2, 3, 4, 5, 6, 7, 8, 9]);
    });

    test('for loop step 2', () {
      final numbers = <int>[];
      for (final num in 1.until(10, step: 2)) {
        numbers.add(num);
      }
      expect(numbers, [1, 3, 5, 7, 9]);
    });
  });
}
