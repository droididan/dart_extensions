extension MapExt on Map<String, dynamic> {
  /// Flatten a nested Map into a single level map
  ///
  /// If you don't want to flatten arrays (with 0, 1,... indexes),
  /// use [safe] mode.
  ///
  /// To avoid circular reference issues or huge calculations,
  /// you can specify the [maxDepth] the function will traverse.
  Map<String, dynamic> flatJson({
    String delimiter = ".",
    bool safe = false,
    int? maxDepth,
  }) {
    final result = <String, dynamic>{};

    void step(
      Map<String, dynamic> obj, [
      String? previousKey,
      int currentDepth = 1,
    ]) {
      obj.forEach((key, value) {
        final newKey = previousKey != null ? "$previousKey$delimiter$key" : key;

        if (maxDepth != null && currentDepth >= maxDepth) {
          result[newKey] = value;
          return;
        }
        if (value is Map<String, dynamic>) {
          return step(value, newKey, currentDepth + 1);
        }
        if (value is List && !safe) {
          return step(
            _listToMap(value as List<Object>),
            newKey,
            currentDepth + 1,
          );
        }
        result[newKey] = value;
      });
    }

    step(this);

    return result;
  }

  Map<String, T> _listToMap<T>(List<T> list) =>
      list.asMap().map((key, value) => MapEntry(key.toString(), value));
}
