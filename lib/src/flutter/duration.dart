import 'dart:async';
import '../date.dart';
extension DurationExt on Duration {
  /// Utility to delay some callback (or code execution).
  ///
  /// Sample:
  /// ```
  ///   await 3.seconds.delay(() {
  ///           ....
  ///   }
  ///
  ///```
  Future delay([FutureOr callback()?]) async => Future.delayed(this, callback);

   static const int daysPerWeek = 7;
  static const int nanosecondsPerMicrosecond = 1000;

  /// Returns the representation in weeks
  int get inWeeks => (inDays / daysPerWeek).ceil();

  /// Adds the Duration to the current DateTime and returns a DateTime in the future
  DateTime get fromNow => DateTime.now() + this;

  /// Subtracts the Duration from the current DateTime and returns a DateTime in the past
  DateTime get ago => DateTime.now() - this;

}
