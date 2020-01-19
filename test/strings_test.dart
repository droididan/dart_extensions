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
import 'package:dart_extensions/strings.dart';

main() {
  group('strings', () {
    test('validateEmail', () {
      expect('name@domain.com'.validateEmail(), true);
      expect('name@domain'.validateEmail(), false);
    });
    test('equalsIgnoreCase', () {
      expect('text'.equalsIgnoreCase('Text'), true);
      expect('text'.equalsIgnoreCase('another'), false);
    });
    test('removeSurrounding', () {
      expect('-text-'.removeSurrounding('-'), 'text');
      expect('-text-'.removeSurrounding('t'), '-text-');
    });
    test('isNullOrEmpty', () {
      expect(''.isNullOrEmpty, true);

      String nullStr;
      expect(nullStr.isNullOrEmpty, true);
      expect('not empty'.isNullOrEmpty, false);
    });

    test('replaceAfter', () {
      expect('name@'.replaceAfter('@', "domain.com"), "name@domain.com");
    });

    test('replaceBefore', () {
      expect('@domain.com'.replaceBefore('@', "name"), "name@domain.com");
    });

    test('anyChar', () {
      expect('test'.anyChar((s) => s == 't'), true);
      expect('test'.anyChar((s) => s == 'd'), false);
    });

    test('toDoubleOrNull', () {
      expect('20.0'.toDoubleOrNull(), 20.0);
      expect('a20.0'.toDoubleOrNull(), null);
    });

    test('removeAllWhiteSpace', () {
      expect('hello world'.removeAllWhiteSpace(), 'helloworld');
      expect(' helloworld '.removeAllWhiteSpace(), 'helloworld');
    });

    test('isNotBlank', () {
      expect('hello world'.isNotBlank, true);
      expect('hello world      '.isNotBlank, true);
      expect(''.isNotBlank, false);
      final String test = null;
      expect(test.isNotBlank, false);
    });

    test('toCharArray', () {
      expect("test".toCharArray(),  ['t','e', 's', 't']);
      expect("".toCharArray(),  []);
    });
  });
}
