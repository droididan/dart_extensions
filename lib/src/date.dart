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
  DateTime? toDateTime() {
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

extension DateExtensions on DateTime {


  bool get isYesterday {
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day - 1;
  }

  /// The list of days in a given month
  List<DateTime> get daysInMonth {
    var first = firstDayOfMonth;
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(Duration(days: daysBefore));
    var last = lastDayOfMonth;

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    var lastToDisplay = last.add(Duration(days: daysAfter));
    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  bool get isFirstDayOfMonth => isSameDay(firstDayOfMonth, this);

  bool get isLastDayOfMonth => isSameDay(lastDayOfMonth, this);

  DateTime get firstDayOfMonth => DateTime(this.year, this.month);

  DateTime get firstDayOfWeek {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    final day = DateTime.utc(this.year, this.month, this.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    var decreaseNum = day.weekday % 7;
    return this.subtract(Duration(days: decreaseNum));
  }

  DateTime get lastDayOfWeek {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    final day = DateTime.utc(this.year, this.month, this.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    var increaseNum = day.weekday % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  DateTime get lastDayOfMonth {
    var beginningNextMonth = (this.month < 12)
        ? DateTime(this.year, this.month + 1, 1)
        : DateTime(this.year + 1, 1, 1);
    return beginningNextMonth.subtract(Duration(days: 1));
  }

  DateTime get previousMonth {
    var year = this.year;
    var month = this.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  DateTime get nextMonth {
    var year = this.year;
    var month = this.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  DateTime get previousWeek => this.subtract(Duration(days: 7));

  DateTime get nextWeek => this.add(Duration(days: 7));

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day);
    b = DateTime.utc(b.year, b.month, b.day);

    var diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
  /// return true if the date is today
  bool isToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentDate = DateTime(year, month, day);
    return today.isAtSameMomentAs(currentDate);
  }

  /// to add years to a [DateTime] add a positive number
  /// to remove years pass a negative number
  addOrRemoveYears(int years) {
    return DateTime(year + years, month, day, minute, second);
  }

  /// to add month to a [DateTime] add a positive number
  /// to remove years pass a negative number
  addOrRemoveMonth(int months) {
    return DateTime(year, month + months, day, minute, second);
  }

  /// to add days to a [DateTime] add a positive number
  /// to remove days pass a negative number
  addOrRemoveDay(int days) {
    return DateTime(year, month, day + days, minute, second);
  }

  /// to add min to a [DateTime] add a positive number
  /// to remove min pass a negative number
  addOrRemoveMinutes(int min) {
    return DateTime(year, month, day, minute + min, second);
  }

  /// to add sec to a [DateTime] add a positive number
  /// to remove sec pass a negative number
  addOrRemoveSeconds(int sec) {
    return DateTime(year, month, day, minute, second + sec);
  }

  ///  Start time of Date times
  DateTime startOfDay() => DateTime(year, month, day);

  DateTime startOfMonth() => DateTime(year, month);

  DateTime startOfYear() => DateTime(year);

  /// DateTime `+` operator
  DateTime operator +(DateTime time) => add(Duration(
      days: time.day, hours: time.hour, minutes: time.minute, seconds: time.second, milliseconds: time.millisecond));

  /// DateTime `-` operator
  DateTime operator -(DateTime time) => subtract(Duration(
      days: time.day, hours: time.hour, minutes: time.minute, seconds: time.second, milliseconds: time.millisecond));

  /// next day
  DateTime tomorrow() => DateTime(year, month, day + 1);

  /// last day
  DateTime yesterday() => DateTime(year, month, day - 1);

  /// return the smaller date between
  DateTime min(DateTime that) => (millisecondsSinceEpoch < that.millisecondsSinceEpoch) ? this : that;

  DateTime max(DateTime that) => (millisecondsSinceEpoch > that.millisecondsSinceEpoch) ? this : that;

  bool get isLeapYear => (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
}
