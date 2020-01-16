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

extension StringExtention on String {
  bool validateEmail() => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);

  /// Return the string only if the delimiter exists in both ends, otherwise it will return the current string
  String removeSurrounding(String delimiter) {
    final prefix = delimiter;
    final suffix = delimiter;

    if ((length >= prefix.length + suffix.length) && startsWith(prefix) && endsWith(suffix)) {
      return substring(prefix.length, length - suffix.length);
    }
    return this;
  }

  /// Return a bool if the string is null or empty
  bool get isNullOrEmpty => this == null || this.isEmpty;

  ///  Replace part of string after the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [missingDelimiterValue] which defaults to the original string.
  String replaceAfter(String delimiter, String replacement, [String missingDelimiterVal]) {
    final index = this.indexOf(delimiter);
    return (index == -1)
        ? missingDelimiterVal.isNullOrEmpty ? this : missingDelimiterVal
        : this.replaceRange(index + 1, this.length, replacement);
  }

  /// Returns the string if it is not `null`, or the empty string otherwise
  String get orEmpty => this ?? "";


  String ifEmpty(Function action) => (this.isEmpty) ? action() : this;

  String get lastIndex {
    if (isNullOrEmpty) return "";
    return this[length - 1];
  }

  /// prints to console this text if it's not empty or null
  void printThis() {
    if (isNullOrEmpty) return;
    print(this.toString());
  }
}

main() {

}
