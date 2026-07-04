import 'package:collection/collection.dart';

enum NamazName {
  Fajr,
  Shuruq,
  Dhohr,
  Asr,
  Maghrib,
  Isha,
}

enum Mode {
  System,
  Light,
  Dark,
}

enum AdhanSound {
  Vibration,
  Standard,
  ShortAdhan,
  AdhanMakkah,
  AdhanMadinah,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (NamazName):
      return NamazName.values.deserialize(value) as T?;
    case (Mode):
      return Mode.values.deserialize(value) as T?;
    case (AdhanSound):
      return AdhanSound.values.deserialize(value) as T?;
    default:
      return null;
  }
}
