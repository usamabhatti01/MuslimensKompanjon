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
  Adhan1,
  Adhan2,
  Adhan3,
  Adhan4,
}

enum SoundName {
  Adhan_1,
  Adhan_2,
  Adhan_3,
  Adhan_4,
  Standard,
}

enum AllahNames {
  AllahNamesAr,
  AllahNamesSv,
}

enum Direction {
  portrait,
  landscape,
}

enum Quran {
  juz,
  sura,
}

enum ShortFilter {
  Latest,
  Popular,
  Old,
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
    case (SoundName):
      return SoundName.values.deserialize(value) as T?;
    case (AllahNames):
      return AllahNames.values.deserialize(value) as T?;
    case (Direction):
      return Direction.values.deserialize(value) as T?;
    case (Quran):
      return Quran.values.deserialize(value) as T?;
    case (ShortFilter):
      return ShortFilter.values.deserialize(value) as T?;
    default:
      return null;
  }
}
