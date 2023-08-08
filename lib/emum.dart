extension EnumExt on dynamic {
  static bool _isEnumItem(enumItem) {
    final splitEnum = enumItem.toString().split('.');
    return splitEnum.length > 1 && splitEnum[0] == enumItem.runtimeType.toString();
  }

  String convertToString({bool camelCase = false}) {
    assert(this != null);
    assert(_isEnumItem(this), '$this of type ${this.runtimeType.toString()} is not an enum item');
    final temp = this.toString().split('.')[1];
    return !camelCase ? temp : camelCaseToWords(temp);
  } 
}
