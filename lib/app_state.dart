import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _youtubeData = (await secureStorage.getStringList('ff_youtubeData'))
              ?.map((x) {
                try {
                  return YoutubeStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _youtubeData;
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_user') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_user') ?? '{}';
          _user =
              UserDataStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      _cityList = (await secureStorage.getStringList('ff_cityList'))
              ?.map((x) {
                try {
                  return CityRecordStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _cityList;
    });
    await _safeInitAsync(() async {
      _adhkarSound =
          await secureStorage.getBool('ff_adhkarSound') ?? _adhkarSound;
    });
    await _safeInitAsync(() async {
      _reelsData = (await secureStorage.getStringList('ff_reelsData'))
              ?.map((x) {
                try {
                  return YoutubeStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _reelsData;
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_channelData') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_channelData') ?? '{}';
          _channelData =
              ChannelStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      _AllahNames = (await secureStorage.getStringList('ff_AllahNames'))
              ?.map((x) {
                try {
                  return AllahNameStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _AllahNames;
    });
    await _safeInitAsync(() async {
      _morningAdhkar = (await secureStorage.getStringList('ff_morningAdhkar'))
              ?.map((x) {
                try {
                  return AdhkarStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _morningAdhkar;
    });
    await _safeInitAsync(() async {
      _eveningAdhkar = (await secureStorage.getStringList('ff_eveningAdhkar'))
              ?.map((x) {
                try {
                  return AdhkarStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _eveningAdhkar;
    });
    await _safeInitAsync(() async {
      _surahsList = (await secureStorage.getStringList('ff_surahsList'))
              ?.map((x) {
                try {
                  return SurahsStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _surahsList;
    });
    await _safeInitAsync(() async {
      _ayahsList = (await secureStorage.getStringList('ff_ayahsList'))
              ?.map((x) {
                try {
                  return AyahsStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _ayahsList;
    });
    await _safeInitAsync(() async {
      _juzList = (await secureStorage.getStringList('ff_juzList'))
              ?.map((x) {
                try {
                  return SurahsStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _juzList;
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_qurantSetting') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_qurantSetting') ?? '{}';
          _qurantSetting = QuranSettingStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      _aboutIslam = (await secureStorage.getStringList('ff_aboutIslam'))
              ?.map((x) {
                try {
                  return OnIslamStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _aboutIslam;
    });
    await _safeInitAsync(() async {
      _mosque = (await secureStorage.getStringList('ff_mosque'))
              ?.map((x) {
                try {
                  return MosqueStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _mosque;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  List<YoutubeStruct> _youtubeData = [
    YoutubeStruct.fromSerializableMap(jsonDecode(
        '{\"video\":\"https://www.youtube.com/watch?v=YF9OgRYxXsQ\",\"title\":\"Har du följt våra Ramadan-påminnelser?\",\"topic\":\"Hjälp oss förbättra kanalen genom att svara på en kort enkät (1 minut):\"}'))
  ];
  List<YoutubeStruct> get youtubeData => _youtubeData;
  set youtubeData(List<YoutubeStruct> value) {
    _youtubeData = value;
    secureStorage.setStringList(
        'ff_youtubeData', value.map((x) => x.serialize()).toList());
  }

  void deleteYoutubeData() {
    secureStorage.delete(key: 'ff_youtubeData');
  }

  void addToYoutubeData(YoutubeStruct value) {
    youtubeData.add(value);
    secureStorage.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  void removeFromYoutubeData(YoutubeStruct value) {
    youtubeData.remove(value);
    secureStorage.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromYoutubeData(int index) {
    youtubeData.removeAt(index);
    secureStorage.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  void updateYoutubeDataAtIndex(
    int index,
    YoutubeStruct Function(YoutubeStruct) updateFn,
  ) {
    youtubeData[index] = updateFn(_youtubeData[index]);
    secureStorage.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInYoutubeData(int index, YoutubeStruct value) {
    youtubeData.insert(index, value);
    secureStorage.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  UserDataStruct _user = UserDataStruct();
  UserDataStruct get user => _user;
  set user(UserDataStruct value) {
    _user = value;
    secureStorage.setString('ff_user', value.serialize());
  }

  void deleteUser() {
    secureStorage.delete(key: 'ff_user');
  }

  void updateUserStruct(Function(UserDataStruct) updateFn) {
    updateFn(_user);
    secureStorage.setString('ff_user', _user.serialize());
  }

  HijriCalenderStruct _hijriData = HijriCalenderStruct();
  HijriCalenderStruct get hijriData => _hijriData;
  set hijriData(HijriCalenderStruct value) {
    _hijriData = value;
  }

  void updateHijriDataStruct(Function(HijriCalenderStruct) updateFn) {
    updateFn(_hijriData);
  }

  List<CityRecordStruct> _cityList = [];
  List<CityRecordStruct> get cityList => _cityList;
  set cityList(List<CityRecordStruct> value) {
    _cityList = value;
    secureStorage.setStringList(
        'ff_cityList', value.map((x) => x.serialize()).toList());
  }

  void deleteCityList() {
    secureStorage.delete(key: 'ff_cityList');
  }

  void addToCityList(CityRecordStruct value) {
    cityList.add(value);
    secureStorage.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  void removeFromCityList(CityRecordStruct value) {
    cityList.remove(value);
    secureStorage.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromCityList(int index) {
    cityList.removeAt(index);
    secureStorage.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  void updateCityListAtIndex(
    int index,
    CityRecordStruct Function(CityRecordStruct) updateFn,
  ) {
    cityList[index] = updateFn(_cityList[index]);
    secureStorage.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInCityList(int index, CityRecordStruct value) {
    cityList.insert(index, value);
    secureStorage.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  bool _adhkarSound = false;
  bool get adhkarSound => _adhkarSound;
  set adhkarSound(bool value) {
    _adhkarSound = value;
    secureStorage.setBool('ff_adhkarSound', value);
  }

  void deleteAdhkarSound() {
    secureStorage.delete(key: 'ff_adhkarSound');
  }

  List<YoutubeStruct> _reelsData = [];
  List<YoutubeStruct> get reelsData => _reelsData;
  set reelsData(List<YoutubeStruct> value) {
    _reelsData = value;
    secureStorage.setStringList(
        'ff_reelsData', value.map((x) => x.serialize()).toList());
  }

  void deleteReelsData() {
    secureStorage.delete(key: 'ff_reelsData');
  }

  void addToReelsData(YoutubeStruct value) {
    reelsData.add(value);
    secureStorage.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  void removeFromReelsData(YoutubeStruct value) {
    reelsData.remove(value);
    secureStorage.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromReelsData(int index) {
    reelsData.removeAt(index);
    secureStorage.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  void updateReelsDataAtIndex(
    int index,
    YoutubeStruct Function(YoutubeStruct) updateFn,
  ) {
    reelsData[index] = updateFn(_reelsData[index]);
    secureStorage.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInReelsData(int index, YoutubeStruct value) {
    reelsData.insert(index, value);
    secureStorage.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  ChannelStruct _channelData = ChannelStruct();
  ChannelStruct get channelData => _channelData;
  set channelData(ChannelStruct value) {
    _channelData = value;
    secureStorage.setString('ff_channelData', value.serialize());
  }

  void deleteChannelData() {
    secureStorage.delete(key: 'ff_channelData');
  }

  void updateChannelDataStruct(Function(ChannelStruct) updateFn) {
    updateFn(_channelData);
    secureStorage.setString('ff_channelData', _channelData.serialize());
  }

  List<AllahNameStruct> _AllahNames = [];
  List<AllahNameStruct> get AllahNames => _AllahNames;
  set AllahNames(List<AllahNameStruct> value) {
    _AllahNames = value;
    secureStorage.setStringList(
        'ff_AllahNames', value.map((x) => x.serialize()).toList());
  }

  void deleteAllahNames() {
    secureStorage.delete(key: 'ff_AllahNames');
  }

  void addToAllahNames(AllahNameStruct value) {
    AllahNames.add(value);
    secureStorage.setStringList(
        'ff_AllahNames', _AllahNames.map((x) => x.serialize()).toList());
  }

  void removeFromAllahNames(AllahNameStruct value) {
    AllahNames.remove(value);
    secureStorage.setStringList(
        'ff_AllahNames', _AllahNames.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAllahNames(int index) {
    AllahNames.removeAt(index);
    secureStorage.setStringList(
        'ff_AllahNames', _AllahNames.map((x) => x.serialize()).toList());
  }

  void updateAllahNamesAtIndex(
    int index,
    AllahNameStruct Function(AllahNameStruct) updateFn,
  ) {
    AllahNames[index] = updateFn(_AllahNames[index]);
    secureStorage.setStringList(
        'ff_AllahNames', _AllahNames.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAllahNames(int index, AllahNameStruct value) {
    AllahNames.insert(index, value);
    secureStorage.setStringList(
        'ff_AllahNames', _AllahNames.map((x) => x.serialize()).toList());
  }

  List<DuaStruct> _duaList = [];
  List<DuaStruct> get duaList => _duaList;
  set duaList(List<DuaStruct> value) {
    _duaList = value;
  }

  void addToDuaList(DuaStruct value) {
    duaList.add(value);
  }

  void removeFromDuaList(DuaStruct value) {
    duaList.remove(value);
  }

  void removeAtIndexFromDuaList(int index) {
    duaList.removeAt(index);
  }

  void updateDuaListAtIndex(
    int index,
    DuaStruct Function(DuaStruct) updateFn,
  ) {
    duaList[index] = updateFn(_duaList[index]);
  }

  void insertAtIndexInDuaList(int index, DuaStruct value) {
    duaList.insert(index, value);
  }

  List<AdhkarStruct> _morningAdhkar = [];
  List<AdhkarStruct> get morningAdhkar => _morningAdhkar;
  set morningAdhkar(List<AdhkarStruct> value) {
    _morningAdhkar = value;
    secureStorage.setStringList(
        'ff_morningAdhkar', value.map((x) => x.serialize()).toList());
  }

  void deleteMorningAdhkar() {
    secureStorage.delete(key: 'ff_morningAdhkar');
  }

  void addToMorningAdhkar(AdhkarStruct value) {
    morningAdhkar.add(value);
    secureStorage.setStringList(
        'ff_morningAdhkar', _morningAdhkar.map((x) => x.serialize()).toList());
  }

  void removeFromMorningAdhkar(AdhkarStruct value) {
    morningAdhkar.remove(value);
    secureStorage.setStringList(
        'ff_morningAdhkar', _morningAdhkar.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMorningAdhkar(int index) {
    morningAdhkar.removeAt(index);
    secureStorage.setStringList(
        'ff_morningAdhkar', _morningAdhkar.map((x) => x.serialize()).toList());
  }

  void updateMorningAdhkarAtIndex(
    int index,
    AdhkarStruct Function(AdhkarStruct) updateFn,
  ) {
    morningAdhkar[index] = updateFn(_morningAdhkar[index]);
    secureStorage.setStringList(
        'ff_morningAdhkar', _morningAdhkar.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMorningAdhkar(int index, AdhkarStruct value) {
    morningAdhkar.insert(index, value);
    secureStorage.setStringList(
        'ff_morningAdhkar', _morningAdhkar.map((x) => x.serialize()).toList());
  }

  List<AdhkarStruct> _eveningAdhkar = [];
  List<AdhkarStruct> get eveningAdhkar => _eveningAdhkar;
  set eveningAdhkar(List<AdhkarStruct> value) {
    _eveningAdhkar = value;
    secureStorage.setStringList(
        'ff_eveningAdhkar', value.map((x) => x.serialize()).toList());
  }

  void deleteEveningAdhkar() {
    secureStorage.delete(key: 'ff_eveningAdhkar');
  }

  void addToEveningAdhkar(AdhkarStruct value) {
    eveningAdhkar.add(value);
    secureStorage.setStringList(
        'ff_eveningAdhkar', _eveningAdhkar.map((x) => x.serialize()).toList());
  }

  void removeFromEveningAdhkar(AdhkarStruct value) {
    eveningAdhkar.remove(value);
    secureStorage.setStringList(
        'ff_eveningAdhkar', _eveningAdhkar.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromEveningAdhkar(int index) {
    eveningAdhkar.removeAt(index);
    secureStorage.setStringList(
        'ff_eveningAdhkar', _eveningAdhkar.map((x) => x.serialize()).toList());
  }

  void updateEveningAdhkarAtIndex(
    int index,
    AdhkarStruct Function(AdhkarStruct) updateFn,
  ) {
    eveningAdhkar[index] = updateFn(_eveningAdhkar[index]);
    secureStorage.setStringList(
        'ff_eveningAdhkar', _eveningAdhkar.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInEveningAdhkar(int index, AdhkarStruct value) {
    eveningAdhkar.insert(index, value);
    secureStorage.setStringList(
        'ff_eveningAdhkar', _eveningAdhkar.map((x) => x.serialize()).toList());
  }

  List<TasbihStruct> _tasbihList = [];
  List<TasbihStruct> get tasbihList => _tasbihList;
  set tasbihList(List<TasbihStruct> value) {
    _tasbihList = value;
  }

  void addToTasbihList(TasbihStruct value) {
    tasbihList.add(value);
  }

  void removeFromTasbihList(TasbihStruct value) {
    tasbihList.remove(value);
  }

  void removeAtIndexFromTasbihList(int index) {
    tasbihList.removeAt(index);
  }

  void updateTasbihListAtIndex(
    int index,
    TasbihStruct Function(TasbihStruct) updateFn,
  ) {
    tasbihList[index] = updateFn(_tasbihList[index]);
  }

  void insertAtIndexInTasbihList(int index, TasbihStruct value) {
    tasbihList.insert(index, value);
  }

  List<AdhkarStruct> _azkhar = [];
  List<AdhkarStruct> get azkhar => _azkhar;
  set azkhar(List<AdhkarStruct> value) {
    _azkhar = value;
  }

  void addToAzkhar(AdhkarStruct value) {
    azkhar.add(value);
  }

  void removeFromAzkhar(AdhkarStruct value) {
    azkhar.remove(value);
  }

  void removeAtIndexFromAzkhar(int index) {
    azkhar.removeAt(index);
  }

  void updateAzkharAtIndex(
    int index,
    AdhkarStruct Function(AdhkarStruct) updateFn,
  ) {
    azkhar[index] = updateFn(_azkhar[index]);
  }

  void insertAtIndexInAzkhar(int index, AdhkarStruct value) {
    azkhar.insert(index, value);
  }

  List<SurahsStruct> _surahsList = [];
  List<SurahsStruct> get surahsList => _surahsList;
  set surahsList(List<SurahsStruct> value) {
    _surahsList = value;
    secureStorage.setStringList(
        'ff_surahsList', value.map((x) => x.serialize()).toList());
  }

  void deleteSurahsList() {
    secureStorage.delete(key: 'ff_surahsList');
  }

  void addToSurahsList(SurahsStruct value) {
    surahsList.add(value);
    secureStorage.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  void removeFromSurahsList(SurahsStruct value) {
    surahsList.remove(value);
    secureStorage.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromSurahsList(int index) {
    surahsList.removeAt(index);
    secureStorage.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  void updateSurahsListAtIndex(
    int index,
    SurahsStruct Function(SurahsStruct) updateFn,
  ) {
    surahsList[index] = updateFn(_surahsList[index]);
    secureStorage.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInSurahsList(int index, SurahsStruct value) {
    surahsList.insert(index, value);
    secureStorage.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  List<AyahsStruct> _ayahsList = [];
  List<AyahsStruct> get ayahsList => _ayahsList;
  set ayahsList(List<AyahsStruct> value) {
    _ayahsList = value;
    secureStorage.setStringList(
        'ff_ayahsList', value.map((x) => x.serialize()).toList());
  }

  void deleteAyahsList() {
    secureStorage.delete(key: 'ff_ayahsList');
  }

  void addToAyahsList(AyahsStruct value) {
    ayahsList.add(value);
    secureStorage.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  void removeFromAyahsList(AyahsStruct value) {
    ayahsList.remove(value);
    secureStorage.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAyahsList(int index) {
    ayahsList.removeAt(index);
    secureStorage.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  void updateAyahsListAtIndex(
    int index,
    AyahsStruct Function(AyahsStruct) updateFn,
  ) {
    ayahsList[index] = updateFn(_ayahsList[index]);
    secureStorage.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAyahsList(int index, AyahsStruct value) {
    ayahsList.insert(index, value);
    secureStorage.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  List<SurahsStruct> _juzList = [];
  List<SurahsStruct> get juzList => _juzList;
  set juzList(List<SurahsStruct> value) {
    _juzList = value;
    secureStorage.setStringList(
        'ff_juzList', value.map((x) => x.serialize()).toList());
  }

  void deleteJuzList() {
    secureStorage.delete(key: 'ff_juzList');
  }

  void addToJuzList(SurahsStruct value) {
    juzList.add(value);
    secureStorage.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  void removeFromJuzList(SurahsStruct value) {
    juzList.remove(value);
    secureStorage.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromJuzList(int index) {
    juzList.removeAt(index);
    secureStorage.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  void updateJuzListAtIndex(
    int index,
    SurahsStruct Function(SurahsStruct) updateFn,
  ) {
    juzList[index] = updateFn(_juzList[index]);
    secureStorage.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInJuzList(int index, SurahsStruct value) {
    juzList.insert(index, value);
    secureStorage.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  QuranSettingStruct _qurantSetting = QuranSettingStruct();
  QuranSettingStruct get qurantSetting => _qurantSetting;
  set qurantSetting(QuranSettingStruct value) {
    _qurantSetting = value;
    secureStorage.setString('ff_qurantSetting', value.serialize());
  }

  void deleteQurantSetting() {
    secureStorage.delete(key: 'ff_qurantSetting');
  }

  void updateQurantSettingStruct(Function(QuranSettingStruct) updateFn) {
    updateFn(_qurantSetting);
    secureStorage.setString('ff_qurantSetting', _qurantSetting.serialize());
  }

  List<OnIslamStruct> _aboutIslam = [];
  List<OnIslamStruct> get aboutIslam => _aboutIslam;
  set aboutIslam(List<OnIslamStruct> value) {
    _aboutIslam = value;
    secureStorage.setStringList(
        'ff_aboutIslam', value.map((x) => x.serialize()).toList());
  }

  void deleteAboutIslam() {
    secureStorage.delete(key: 'ff_aboutIslam');
  }

  void addToAboutIslam(OnIslamStruct value) {
    aboutIslam.add(value);
    secureStorage.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  void removeFromAboutIslam(OnIslamStruct value) {
    aboutIslam.remove(value);
    secureStorage.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAboutIslam(int index) {
    aboutIslam.removeAt(index);
    secureStorage.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  void updateAboutIslamAtIndex(
    int index,
    OnIslamStruct Function(OnIslamStruct) updateFn,
  ) {
    aboutIslam[index] = updateFn(_aboutIslam[index]);
    secureStorage.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAboutIslam(int index, OnIslamStruct value) {
    aboutIslam.insert(index, value);
    secureStorage.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  List<MosqueStruct> _mosque = [];
  List<MosqueStruct> get mosque => _mosque;
  set mosque(List<MosqueStruct> value) {
    _mosque = value;
    secureStorage.setStringList(
        'ff_mosque', value.map((x) => x.serialize()).toList());
  }

  void deleteMosque() {
    secureStorage.delete(key: 'ff_mosque');
  }

  void addToMosque(MosqueStruct value) {
    mosque.add(value);
    secureStorage.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  void removeFromMosque(MosqueStruct value) {
    mosque.remove(value);
    secureStorage.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMosque(int index) {
    mosque.removeAt(index);
    secureStorage.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  void updateMosqueAtIndex(
    int index,
    MosqueStruct Function(MosqueStruct) updateFn,
  ) {
    mosque[index] = updateFn(_mosque[index]);
    secureStorage.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMosque(int index, MosqueStruct value) {
    mosque.insert(index, value);
    secureStorage.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  bool _autoPlay = false;
  bool get autoPlay => _autoPlay;
  set autoPlay(bool value) {
    _autoPlay = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
