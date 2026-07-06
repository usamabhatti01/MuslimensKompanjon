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
      if (await secureStorage.read(key: 'ff_AboutIslam') != null) {
        try {
          _AboutIslam =
              jsonDecode(await secureStorage.getString('ff_AboutIslam') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
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

  dynamic _AboutIslam = jsonDecode(
      '{\"tabs\":[{\"id\":1,\"title\":\"Introduction\",\"subtitle\":\"Welcome to Guiding Reminders\",\"pageHeading\":\"Growing in Faith\",\"imagePath\":\"https://picsum.photos/seed/intro/600/400\",\"audioPath\":\"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3\",\"contentBody\":\"Islam is a beautiful journey of continuous growth.\",\"contentBody2\":\"These daily reminders are designed to help us connect with Allah.\",\"contentBody3\":\"Bismillah.\"},{\"id\":2,\"title\":\"Day 1\",\"subtitle\":\"Prayer is your foundation\",\"pageHeading\":\"The Pillar of Salah\",\"imagePath\":\"https://picsum.photos/seed/day1/600/400\",\"audioPath\":\"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3\",\"contentBody\":\"Salah is the first thing we will be asked about.\",\"contentBody2\":\"It is our direct connection to the Creator.\",\"contentBody3\":\"Make it your priority today.\"},{\"id\":3,\"title\":\"Day 2\",\"subtitle\":\"The beauty of good character\",\"pageHeading\":\"Perfecting Akhlaq\",\"imagePath\":\"\",\"audioPath\":\"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3\",\"contentBody\":\"The Prophet (PBUH) was sent to perfect good character.\",\"contentBody2\":\"Kindness, honesty, and respect are at the core of our faith.\",\"contentBody3\":\"\"},{\"id\":4,\"title\":\"Day 3\",\"subtitle\":\"Trusting Allah\'s plan\",\"pageHeading\":\"The Power of Sabr\",\"imagePath\":\"https://picsum.photos/seed/day3/600/400\",\"audioPath\":\"\",\"contentBody\":\"Patience is not just waiting; it is how we behave while waiting.\",\"contentBody2\":\"Trust that Allah\'s timing is always perfect.\",\"contentBody3\":\"\"},{\"id\":5,\"title\":\"Day 4\",\"subtitle\":\"Recognizing our blessings\",\"pageHeading\":\"Gratitude (Shukr)\",\"imagePath\":\"https://picsum.photos/seed/day4/600/400\",\"audioPath\":\"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3\",\"contentBody\":\"If you are grateful, Allah will give you more.\",\"contentBody2\":\"Take a moment today to thank Him.\",\"contentBody3\":\"\"}]}');
  dynamic get AboutIslam => _AboutIslam;
  set AboutIslam(dynamic value) {
    _AboutIslam = value;
    secureStorage.setString('ff_AboutIslam', jsonEncode(value));
  }

  void deleteAboutIslam() {
    secureStorage.delete(key: 'ff_AboutIslam');
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
