extension EnumExtensions on Enum {
  bool operator <(Enum other) => index < other.index;
  bool operator <=(Enum other) => index < other.index;
  bool operator >(Enum other) => index > other.index;
  bool operator >=(Enum other) => index >= other.index;
}
