extension EnumExtensions on Enum {
  bool operator <(Enum other) => other.index < index;
  bool operator <=(Enum other) => other.index <= index;
  bool operator >(Enum other) => other.index > index;
  bool operator >=(Enum other) => other.index >= index;
}
