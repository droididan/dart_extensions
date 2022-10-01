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
import 'package:dart_extensions/src/string_ext.dart';

main() {
  group('strings', () {
    test('it should wrap a string', () {
      expect('one two three four'.wrapString(2), 'one two\nthree four');
      expect('one two three four'.wrapString(3), 'one two three\nfour');
    });

    test('capitalize a string', () {
      expect('string'.capitalize(), 'String');
      expect('hello world'.capitalize(), 'Hello world');
    });

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
      expect(''.isEmptyOrNull, true);

      String? nullStr;
      expect(nullStr.isEmptyOrNull, true);
      expect('not empty'.isEmptyOrNull, false);
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
      final String? test = null;
      expect(test.isNotBlank, false);
    });

    test('toCharArray', () {
      expect("test".toCharArray(), ['t', 'e', 's', 't']);
      expect("".toCharArray(), []);
    });

    test('insert', () {
      expect('test'.insert(1, 't'), 'ttest');
      expect('123456890'.insert(6, '7'), '1234567890');
      expect('dart cool'.insert(4, ' is'), 'dart is cool');
      // how about multiline?
      expect('flutter\ncooler'.insert(7, '\nis'), 'flutter\nis\ncooler');
    });

    test('isNullOrWhiteSpace', () {
      expect('test'.isNullOrWhiteSpace, false);
      expect('   '.isNullOrWhiteSpace, true);
      expect(null.isNullOrWhiteSpace, true);
      expect(''.isNullOrWhiteSpace, true);
      expect('  test'.isNullOrWhiteSpace, false);
      expect('test  '.isNullOrWhiteSpace, false);
      expect('te  st'.isNullOrWhiteSpace, false);
      expect('  te  st  '.isNullOrWhiteSpace, false);
    });

    test('asBool', () {
      // strings, it is case insensitive
      expect('true'.asBool, true);
      expect('True'.asBool, true);
      expect('false'.asBool, false);
      expect('False'.asBool, false);
      expect('yes'.asBool, true);
      expect('YES'.asBool, true);
      expect('no'.asBool, false);
      expect('NO'.asBool, false);

      // string numbers
      expect('232'.asBool, true);
      expect('1'.asBool, true);
      expect('0'.asBool, false);
      expect('-1'.asBool, false);
    });

    test('limitFromEnd', () {
      const source = "01234";
      expect(source.limitFromEnd(10), source);
      expect(source.limitFromEnd(2), "34");
    });
    test('limitFromStart', () {
      const source = "01234";
      expect(source.limitFromStart(10), source);
      expect(source.limitFromStart(2), "01");
    });
  });
}
