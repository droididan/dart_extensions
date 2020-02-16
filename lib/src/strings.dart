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

import 'package:intl/intl.dart';

enum Gender { male, female }

class Message {
  final String male, female, other;

  Message({this.male, this.female, this.other})
      : assert(male.isEmptyOrNull),
        assert(female.isEmptyOrNull),
        assert(other.isEmptyOrNull);
}

extension StringExtensions on String {
  String generateMessageByGender({Gender gender, Message message}) =>
      Intl.gender(gender.toString(),
          male: '$this ${message.male}',
          female: '$this ${message.female}',
          other: '$this ${message.other}');

  bool validateEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  bool equalsIgnoreCase(String other) =>
      (this == null && other == null) ||
      (this != null && other != null && toLowerCase() == other.toLowerCase());

  /// Return the string only if the delimiter exists in both ends, otherwise it will return the current string
  String removeSurrounding(String delimiter) {
    final prefix = delimiter;
    final suffix = delimiter;

    if ((length >= prefix.length + suffix.length) &&
        startsWith(prefix) &&
        endsWith(suffix)) {
      return substring(prefix.length, length - suffix.length);
    }
    return this;
  }

  /// Return a bool if the string is null or empty
  bool get isEmptyOrNull => this == null || isEmpty;

  ///  Replace part of string after the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [defaultValue] which defaults to the original string.
  String replaceAfter(String delimiter, String replacement,
      [String defaultValue]) {
    final index = indexOf(delimiter);
    return (index == -1)
        ? defaultValue.isEmptyOrNull ? this : defaultValue
        : replaceRange(index + 1, length, replacement);
  }

  ///
  /// Replace part of string before the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [missingDelimiterValue] which defaults to the original string.
  String replaceBefore(String delimiter, String replacement,
      [String defaultValue]) {
    final index = indexOf(delimiter);
    return (index == -1)
        ? defaultValue.isEmptyOrNull ? this : defaultValue
        : replaceRange(0, index, replacement);
  }

  ///Returns `true` if at least one element matches the given [predicate].
  /// the [predicate] should have only one character
  bool anyChar(bool predicate(String element)) =>
      split('').any((s) => predicate(s));

  /// Returns the string if it is not `null`, or the empty string otherwise
  String get orEmpty => this ?? "";

  // if the string is empty perform an action
  String ifEmpty(Function action) => isEmpty ? action() : this;

  String get lastIndex {
    if (isEmptyOrNull) return "";
    return this[length - 1];
  }

  /// prints to console this text if it's not empty or null
  void printThis() {
    if (isEmptyOrNull) return;
    print(toString());
  }

  /// Parses the string as an double or returns `null` if it is not a number.
  double toDoubleOrNull() => double.tryParse(this);

  /// Parses the string as an int or returns `null` if it is not a number.
  int toIntOrNull() => int.tryParse(this);

  /// Returns a String without white space at all
  /// "hello world" // helloworld
  String removeAllWhiteSpace() => replaceAll(RegExp(r"\s+\b|\b\s"), "");

  /// Returns true if s is neither null, empty nor is solely made of whitespace characters.
  bool get isNotBlank => this != null && trim().isNotEmpty;

  /// Returns a list of chars from a String
  List<String> toCharArray() => isNotBlank ? split('') : [];

  /// Returns a new string in which a specified string is inserted at a specified index position in this instance.
  String insert(int index, String str) =>
      (List<String>.from(this.toCharArray())..insert(index, str)).join();

  /// Indicates whether a specified string is `null`, `empty`, or consists only of `white-space` characters.
  bool get isNullOrWhiteSpace {
    var length = (this?.split('') ?? []).where((x) => x == ' ').length;
    return length == (this?.length ?? 0) || this.isEmptyOrNull;
  }

  /// Shrink a string to be no more than [maxSize] in length, extending from the end.
  /// For example, in a string with 10 charachters, a [maxSize] of 3 would return the last 3 charachters.
  String limitFromEnd(int maxSize) => this?.length ?? 0 < maxSize
      ? this
      : this.substring(this.length - maxSize);

    /// Shrink a string to be no more than [maxSize] in length, extending from the start.
  /// For example, in a string with 10 charachters, a [maxSize] of 3 would return the first 3 charachters.
  String limitFromStart(int maxSize) => this?.length ?? 0 < maxSize ? this : this.substring(0, maxSize);

  /// Convert this string into boolean.
  ///
  /// Returns `true` if this string is any of these values: `"true"`, `"yes"`, `"1"`, or if the string is a number and greater than 0, `false` if less than 1. This is also case insensitive.
  bool get asBool {
    var s = this.trim().toLowerCase();
    num n;
    try {
      n = num.parse(s);
    } catch (e) {
      n = -1;
    }
    return s == 'true' || s == 'yes' || n > 0;
  }
}
