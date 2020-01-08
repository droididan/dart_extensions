library flutter_extentions;



extension CollectionsExt<T> on Iterable<T> {

  // get the first element return null
  T get firstOrNull => elementAtOrNull(0);

  // get the first element or provider default
  // example:
  // var name = [danny, ronny, idan].firstOrDefault["nuni"]; // danny
  // var name = [].firstOrDefault["nuni"]; // nuni
  T firstOrDefault(T defaultValue) => firstOrNull ?? defaultValue;


  // get an element at specific index or return null
  T elementAtOrNull(int index) {
    return _elementOrNull(index, (_) => null);
  }

  _elementOrNull(int index, T defaultElement(int index)) {
    // if our index is smaller then 0 return the default
    if (index < 0) return defaultElement(index);

    var counter = 0;
    for (var element in this) {
      if (index == counter++) {
        return element;
      }
    }

    return defaultElement(index);
  }
}