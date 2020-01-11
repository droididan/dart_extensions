extension DateExt on DateTime {

  /// to add years to a [DateTime] add a positive number
  /// to remove years pass a negative number
  addOrRemoveYears(int years) {
    return DateTime(this.year + years, this.month, this.day, this.minute, this.second);
  }

  /// to add month to a [DateTime] add a positive number
  /// to remove years pass a negative number
  addOrRemoveMonth(int months) {
    return DateTime(this.year, this.month + months, this.day, this.minute, this.second);
  }

  /// to add days to a [DateTime] add a positive number
  /// to remove days pass a negative number
  addOrRemoveDay(int days) {
    return DateTime(this.year, this.month, this.day + days, this.minute, this.second);
  }

  /// to add min to a [DateTime] add a positive number
  /// to remove min pass a negative number
  addOrRemoveMinutes(int min) {
    return DateTime(this.year, this.month, this.day, this.minute + min, this.second);
  }

  /// to add sec to a [DateTime] add a positive number
  /// to remove sec pass a negative number
  addOrRemoveSeconds(int sec) {
    return DateTime(this.year, this.month, this.day, this.minute, this.second + sec);
  }
}