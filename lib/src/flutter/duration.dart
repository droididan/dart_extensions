import 'dart:async';

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
}
