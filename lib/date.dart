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

extension DateString on String {

  /// Parse string to [DateTime]
  DateTime toDateTime() {
    try {
      return DateTime.tryParse(this);
    } on Exception catch (_) {
      return null;
    }
  }
}

extension DateInt on int {
  Duration toMilliseconds() => Duration(milliseconds: this);

  Duration toSeconds() => Duration(seconds: this);

  Duration toMinutes() => Duration(minutes: this);

  Duration toHours() => Duration(hours: this);

  Duration toDays() => Duration(days: this);
}

extension DateExt on DateTime {

  /// return true if the date is today
  bool isToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentDate = DateTime(this.year, this.month, this.day);
    return today.isAtSameMomentAs(currentDate);
  }

  /// to add years to a [DateTime] add a positive number
  /// to remove years pass a negative number
  addOrRemoveYears(int years) {
    return DateTime(
        this.year + years, this.month, this.day, this.minute, this.second);
  }

  /// to add month to a [DateTime] add a positive number
  /// to remove years pass a negative number
  addOrRemoveMonth(int months) {
    return DateTime(
        this.year, this.month + months, this.day, this.minute, this.second);
  }

  /// to add days to a [DateTime] add a positive number
  /// to remove days pass a negative number
  addOrRemoveDay(int days) {
    return DateTime(
        this.year, this.month, this.day + days, this.minute, this.second);
  }

  /// to add min to a [DateTime] add a positive number
  /// to remove min pass a negative number
  addOrRemoveMinutes(int min) {
    return DateTime(
        this.year, this.month, this.day, this.minute + min, this.second);
  }

  /// to add sec to a [DateTime] add a positive number
  /// to remove sec pass a negative number
  addOrRemoveSeconds(int sec) {
    return DateTime(
        this.year, this.month, this.day, this.minute, this.second + sec);
  }

  ///  Start time of Date times
  DateTime startOfDay() => DateTime(year, month, day);

  DateTime startOfMonth() => DateTime(year, month);

  DateTime startOfYear() => DateTime(year);

  /// DateTime `+` operator
  DateTime operator +(DateTime time) =>
      this.add(Duration(
          days: time.day,
          hours: time.hour,
          minutes: time.minute,
          seconds: time.second,
          milliseconds: time.millisecond));

  /// DateTime `-` operator
  DateTime operator -(DateTime time) =>
      this.subtract(Duration(
          days: time.day,
          hours: time.hour,
          minutes: time.minute,
          seconds: time.second,
          milliseconds: time.millisecond));

  /// next day
  DateTime tomorrow() => DateTime(year, month, day + 1);

  /// last day
  DateTime yesterday() => DateTime(year, month, day - 1);


  /// return the smaller date between
  DateTime min(DateTime that) =>
      (this.millisecondsSinceEpoch < that.millisecondsSinceEpoch) ? this : that;

  DateTime max(DateTime that) =>
      (this.millisecondsSinceEpoch > that.millisecondsSinceEpoch) ? this : that;

  bool get isLeapYear =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
}

main() {
  print(DateTime.now().isLeapYear);
}