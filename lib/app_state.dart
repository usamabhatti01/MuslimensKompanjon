import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _youtubeData = prefs
              .getStringList('ff_youtubeData')
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
    _safeInit(() {
      if (prefs.containsKey('ff_user')) {
        try {
          final serializedData = prefs.getString('ff_user') ?? '{}';
          _user =
              UserDataStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _cityList = prefs
              .getStringList('ff_cityList')
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
    _safeInit(() {
      _reelsData = prefs
              .getStringList('ff_reelsData')
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
    _safeInit(() {
      if (prefs.containsKey('ff_channelData')) {
        try {
          final serializedData = prefs.getString('ff_channelData') ?? '{}';
          _channelData =
              ChannelStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _AllahNames = prefs
              .getStringList('ff_AllahNames')
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
    _safeInit(() {
      _surahsList = prefs
              .getStringList('ff_surahsList')
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
    _safeInit(() {
      _ayahsList = prefs
              .getStringList('ff_ayahsList')
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
    _safeInit(() {
      _juzList = prefs
              .getStringList('ff_juzList')
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
    _safeInit(() {
      if (prefs.containsKey('ff_qurantSetting')) {
        try {
          final serializedData = prefs.getString('ff_qurantSetting') ?? '{}';
          _qurantSetting =
              FontSettingStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _aboutIslam = prefs
              .getStringList('ff_aboutIslam')
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
    _safeInit(() {
      _mosque = prefs
              .getStringList('ff_mosque')
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
    _safeInit(() {
      _youtubePost = prefs
              .getStringList('ff_youtubePost')
              ?.map((x) {
                try {
                  return PostStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _youtubePost;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_adhkarSetting')) {
        try {
          final serializedData = prefs.getString('ff_adhkarSetting') ?? '{}';
          _adhkarSetting =
              FontSettingStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _adhkar = prefs
              .getStringList('ff_adhkar')
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
          _adhkar;
    });
    _safeInit(() {
      _userFvtCities = prefs
              .getStringList('ff_userFvtCities')
              ?.map((x) {
                try {
                  return HistoryStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _userFvtCities;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_tasbihSetting')) {
        try {
          final serializedData = prefs.getString('ff_tasbihSetting') ?? '{}';
          _tasbihSetting =
              FontSettingStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_DuasSetting')) {
        try {
          final serializedData = prefs.getString('ff_DuasSetting') ?? '{}';
          _DuasSetting =
              FontSettingStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _haptic = prefs.getBool('ff_haptic') ?? _haptic;
    });
    _safeInit(() {
      _availablePrayerYears = prefs
              .getStringList('ff_availablePrayerYears')
              ?.map(int.parse)
              .toList() ??
          _availablePrayerYears;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<YoutubeStruct> _youtubeData = [
    YoutubeStruct.fromSerializableMap(jsonDecode(
        '{\"video\":\"https://www.youtube.com/watch?v=YF9OgRYxXsQ\",\"title\":\"Har du följt våra Ramadan-påminnelser?\",\"topic\":\"Hjälp oss förbättra kanalen genom att svara på en kort enkät (1 minut):\"}'))
  ];
  List<YoutubeStruct> get youtubeData => _youtubeData;
  set youtubeData(List<YoutubeStruct> value) {
    _youtubeData = value;
    prefs.setStringList(
        'ff_youtubeData', value.map((x) => x.serialize()).toList());
  }

  void addToYoutubeData(YoutubeStruct value) {
    youtubeData.add(value);
    prefs.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  void removeFromYoutubeData(YoutubeStruct value) {
    youtubeData.remove(value);
    prefs.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromYoutubeData(int index) {
    youtubeData.removeAt(index);
    prefs.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  void updateYoutubeDataAtIndex(
    int index,
    YoutubeStruct Function(YoutubeStruct) updateFn,
  ) {
    youtubeData[index] = updateFn(_youtubeData[index]);
    prefs.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInYoutubeData(int index, YoutubeStruct value) {
    youtubeData.insert(index, value);
    prefs.setStringList(
        'ff_youtubeData', _youtubeData.map((x) => x.serialize()).toList());
  }

  UserDataStruct _user = UserDataStruct();
  UserDataStruct get user => _user;
  set user(UserDataStruct value) {
    _user = value;
    prefs.setString('ff_user', value.serialize());
  }

  void updateUserStruct(Function(UserDataStruct) updateFn) {
    updateFn(_user);
    prefs.setString('ff_user', _user.serialize());
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
    prefs.setStringList(
        'ff_cityList', value.map((x) => x.serialize()).toList());
  }

  void addToCityList(CityRecordStruct value) {
    cityList.add(value);
    prefs.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  void removeFromCityList(CityRecordStruct value) {
    cityList.remove(value);
    prefs.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromCityList(int index) {
    cityList.removeAt(index);
    prefs.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  void updateCityListAtIndex(
    int index,
    CityRecordStruct Function(CityRecordStruct) updateFn,
  ) {
    cityList[index] = updateFn(_cityList[index]);
    prefs.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInCityList(int index, CityRecordStruct value) {
    cityList.insert(index, value);
    prefs.setStringList(
        'ff_cityList', _cityList.map((x) => x.serialize()).toList());
  }

  List<YoutubeStruct> _reelsData = [];
  List<YoutubeStruct> get reelsData => _reelsData;
  set reelsData(List<YoutubeStruct> value) {
    _reelsData = value;
    prefs.setStringList(
        'ff_reelsData', value.map((x) => x.serialize()).toList());
  }

  void addToReelsData(YoutubeStruct value) {
    reelsData.add(value);
    prefs.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  void removeFromReelsData(YoutubeStruct value) {
    reelsData.remove(value);
    prefs.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromReelsData(int index) {
    reelsData.removeAt(index);
    prefs.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  void updateReelsDataAtIndex(
    int index,
    YoutubeStruct Function(YoutubeStruct) updateFn,
  ) {
    reelsData[index] = updateFn(_reelsData[index]);
    prefs.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInReelsData(int index, YoutubeStruct value) {
    reelsData.insert(index, value);
    prefs.setStringList(
        'ff_reelsData', _reelsData.map((x) => x.serialize()).toList());
  }

  ChannelStruct _channelData = ChannelStruct();
  ChannelStruct get channelData => _channelData;
  set channelData(ChannelStruct value) {
    _channelData = value;
    prefs.setString('ff_channelData', value.serialize());
  }

  void updateChannelDataStruct(Function(ChannelStruct) updateFn) {
    updateFn(_channelData);
    prefs.setString('ff_channelData', _channelData.serialize());
  }

  List<AllahNameStruct> _AllahNames = [];
  List<AllahNameStruct> get AllahNames => _AllahNames;
  set AllahNames(List<AllahNameStruct> value) {
    _AllahNames = value;
    prefs.setStringList(
        'ff_AllahNames', value.map((x) => x.serialize()).toList());
  }

  void addToAllahNames(AllahNameStruct value) {
    AllahNames.add(value);
    prefs.setStringList(
        'ff_AllahNames', _AllahNames.map((x) => x.serialize()).toList());
  }

  void removeFromAllahNames(AllahNameStruct value) {
    AllahNames.remove(value);
    prefs.setStringList(
        'ff_AllahNames', _AllahNames.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAllahNames(int index) {
    AllahNames.removeAt(index);
    prefs.setStringList(
        'ff_AllahNames', _AllahNames.map((x) => x.serialize()).toList());
  }

  void updateAllahNamesAtIndex(
    int index,
    AllahNameStruct Function(AllahNameStruct) updateFn,
  ) {
    AllahNames[index] = updateFn(_AllahNames[index]);
    prefs.setStringList(
        'ff_AllahNames', _AllahNames.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAllahNames(int index, AllahNameStruct value) {
    AllahNames.insert(index, value);
    prefs.setStringList(
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

  List<SurahsStruct> _surahsList = [];
  List<SurahsStruct> get surahsList => _surahsList;
  set surahsList(List<SurahsStruct> value) {
    _surahsList = value;
    prefs.setStringList(
        'ff_surahsList', value.map((x) => x.serialize()).toList());
  }

  void addToSurahsList(SurahsStruct value) {
    surahsList.add(value);
    prefs.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  void removeFromSurahsList(SurahsStruct value) {
    surahsList.remove(value);
    prefs.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromSurahsList(int index) {
    surahsList.removeAt(index);
    prefs.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  void updateSurahsListAtIndex(
    int index,
    SurahsStruct Function(SurahsStruct) updateFn,
  ) {
    surahsList[index] = updateFn(_surahsList[index]);
    prefs.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInSurahsList(int index, SurahsStruct value) {
    surahsList.insert(index, value);
    prefs.setStringList(
        'ff_surahsList', _surahsList.map((x) => x.serialize()).toList());
  }

  List<AyahsStruct> _ayahsList = [];
  List<AyahsStruct> get ayahsList => _ayahsList;
  set ayahsList(List<AyahsStruct> value) {
    _ayahsList = value;
    prefs.setStringList(
        'ff_ayahsList', value.map((x) => x.serialize()).toList());
  }

  void addToAyahsList(AyahsStruct value) {
    ayahsList.add(value);
    prefs.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  void removeFromAyahsList(AyahsStruct value) {
    ayahsList.remove(value);
    prefs.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAyahsList(int index) {
    ayahsList.removeAt(index);
    prefs.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  void updateAyahsListAtIndex(
    int index,
    AyahsStruct Function(AyahsStruct) updateFn,
  ) {
    ayahsList[index] = updateFn(_ayahsList[index]);
    prefs.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAyahsList(int index, AyahsStruct value) {
    ayahsList.insert(index, value);
    prefs.setStringList(
        'ff_ayahsList', _ayahsList.map((x) => x.serialize()).toList());
  }

  List<SurahsStruct> _juzList = [];
  List<SurahsStruct> get juzList => _juzList;
  set juzList(List<SurahsStruct> value) {
    _juzList = value;
    prefs.setStringList('ff_juzList', value.map((x) => x.serialize()).toList());
  }

  void addToJuzList(SurahsStruct value) {
    juzList.add(value);
    prefs.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  void removeFromJuzList(SurahsStruct value) {
    juzList.remove(value);
    prefs.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromJuzList(int index) {
    juzList.removeAt(index);
    prefs.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  void updateJuzListAtIndex(
    int index,
    SurahsStruct Function(SurahsStruct) updateFn,
  ) {
    juzList[index] = updateFn(_juzList[index]);
    prefs.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInJuzList(int index, SurahsStruct value) {
    juzList.insert(index, value);
    prefs.setStringList(
        'ff_juzList', _juzList.map((x) => x.serialize()).toList());
  }

  FontSettingStruct _qurantSetting = FontSettingStruct();
  FontSettingStruct get qurantSetting => _qurantSetting;
  set qurantSetting(FontSettingStruct value) {
    _qurantSetting = value;
    prefs.setString('ff_qurantSetting', value.serialize());
  }

  void updateQurantSettingStruct(Function(FontSettingStruct) updateFn) {
    updateFn(_qurantSetting);
    prefs.setString('ff_qurantSetting', _qurantSetting.serialize());
  }

  List<OnIslamStruct> _aboutIslam = [];
  List<OnIslamStruct> get aboutIslam => _aboutIslam;
  set aboutIslam(List<OnIslamStruct> value) {
    _aboutIslam = value;
    prefs.setStringList(
        'ff_aboutIslam', value.map((x) => x.serialize()).toList());
  }

  void addToAboutIslam(OnIslamStruct value) {
    aboutIslam.add(value);
    prefs.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  void removeFromAboutIslam(OnIslamStruct value) {
    aboutIslam.remove(value);
    prefs.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAboutIslam(int index) {
    aboutIslam.removeAt(index);
    prefs.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  void updateAboutIslamAtIndex(
    int index,
    OnIslamStruct Function(OnIslamStruct) updateFn,
  ) {
    aboutIslam[index] = updateFn(_aboutIslam[index]);
    prefs.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAboutIslam(int index, OnIslamStruct value) {
    aboutIslam.insert(index, value);
    prefs.setStringList(
        'ff_aboutIslam', _aboutIslam.map((x) => x.serialize()).toList());
  }

  List<MosqueStruct> _mosque = [];
  List<MosqueStruct> get mosque => _mosque;
  set mosque(List<MosqueStruct> value) {
    _mosque = value;
    prefs.setStringList('ff_mosque', value.map((x) => x.serialize()).toList());
  }

  void addToMosque(MosqueStruct value) {
    mosque.add(value);
    prefs.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  void removeFromMosque(MosqueStruct value) {
    mosque.remove(value);
    prefs.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMosque(int index) {
    mosque.removeAt(index);
    prefs.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  void updateMosqueAtIndex(
    int index,
    MosqueStruct Function(MosqueStruct) updateFn,
  ) {
    mosque[index] = updateFn(_mosque[index]);
    prefs.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMosque(int index, MosqueStruct value) {
    mosque.insert(index, value);
    prefs.setStringList(
        'ff_mosque', _mosque.map((x) => x.serialize()).toList());
  }

  bool _searchBar = false;
  bool get searchBar => _searchBar;
  set searchBar(bool value) {
    _searchBar = value;
  }

  List<PostStruct> _youtubePost = [];
  List<PostStruct> get youtubePost => _youtubePost;
  set youtubePost(List<PostStruct> value) {
    _youtubePost = value;
    prefs.setStringList(
        'ff_youtubePost', value.map((x) => x.serialize()).toList());
  }

  void addToYoutubePost(PostStruct value) {
    youtubePost.add(value);
    prefs.setStringList(
        'ff_youtubePost', _youtubePost.map((x) => x.serialize()).toList());
  }

  void removeFromYoutubePost(PostStruct value) {
    youtubePost.remove(value);
    prefs.setStringList(
        'ff_youtubePost', _youtubePost.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromYoutubePost(int index) {
    youtubePost.removeAt(index);
    prefs.setStringList(
        'ff_youtubePost', _youtubePost.map((x) => x.serialize()).toList());
  }

  void updateYoutubePostAtIndex(
    int index,
    PostStruct Function(PostStruct) updateFn,
  ) {
    youtubePost[index] = updateFn(_youtubePost[index]);
    prefs.setStringList(
        'ff_youtubePost', _youtubePost.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInYoutubePost(int index, PostStruct value) {
    youtubePost.insert(index, value);
    prefs.setStringList(
        'ff_youtubePost', _youtubePost.map((x) => x.serialize()).toList());
  }

  FontSettingStruct _adhkarSetting = FontSettingStruct();
  FontSettingStruct get adhkarSetting => _adhkarSetting;
  set adhkarSetting(FontSettingStruct value) {
    _adhkarSetting = value;
    prefs.setString('ff_adhkarSetting', value.serialize());
  }

  void updateAdhkarSettingStruct(Function(FontSettingStruct) updateFn) {
    updateFn(_adhkarSetting);
    prefs.setString('ff_adhkarSetting', _adhkarSetting.serialize());
  }

  List<AdhkarStruct> _adhkar = [];
  List<AdhkarStruct> get adhkar => _adhkar;
  set adhkar(List<AdhkarStruct> value) {
    _adhkar = value;
    prefs.setStringList('ff_adhkar', value.map((x) => x.serialize()).toList());
  }

  void addToAdhkar(AdhkarStruct value) {
    adhkar.add(value);
    prefs.setStringList(
        'ff_adhkar', _adhkar.map((x) => x.serialize()).toList());
  }

  void removeFromAdhkar(AdhkarStruct value) {
    adhkar.remove(value);
    prefs.setStringList(
        'ff_adhkar', _adhkar.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAdhkar(int index) {
    adhkar.removeAt(index);
    prefs.setStringList(
        'ff_adhkar', _adhkar.map((x) => x.serialize()).toList());
  }

  void updateAdhkarAtIndex(
    int index,
    AdhkarStruct Function(AdhkarStruct) updateFn,
  ) {
    adhkar[index] = updateFn(_adhkar[index]);
    prefs.setStringList(
        'ff_adhkar', _adhkar.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAdhkar(int index, AdhkarStruct value) {
    adhkar.insert(index, value);
    prefs.setStringList(
        'ff_adhkar', _adhkar.map((x) => x.serialize()).toList());
  }

  List<HistoryStruct> _userFvtCities = [];
  List<HistoryStruct> get userFvtCities => _userFvtCities;
  set userFvtCities(List<HistoryStruct> value) {
    _userFvtCities = value;
    prefs.setStringList(
        'ff_userFvtCities', value.map((x) => x.serialize()).toList());
  }

  void addToUserFvtCities(HistoryStruct value) {
    userFvtCities.add(value);
    prefs.setStringList(
        'ff_userFvtCities', _userFvtCities.map((x) => x.serialize()).toList());
  }

  void removeFromUserFvtCities(HistoryStruct value) {
    userFvtCities.remove(value);
    prefs.setStringList(
        'ff_userFvtCities', _userFvtCities.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromUserFvtCities(int index) {
    userFvtCities.removeAt(index);
    prefs.setStringList(
        'ff_userFvtCities', _userFvtCities.map((x) => x.serialize()).toList());
  }

  void updateUserFvtCitiesAtIndex(
    int index,
    HistoryStruct Function(HistoryStruct) updateFn,
  ) {
    userFvtCities[index] = updateFn(_userFvtCities[index]);
    prefs.setStringList(
        'ff_userFvtCities', _userFvtCities.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInUserFvtCities(int index, HistoryStruct value) {
    userFvtCities.insert(index, value);
    prefs.setStringList(
        'ff_userFvtCities', _userFvtCities.map((x) => x.serialize()).toList());
  }

  FontSettingStruct _tasbihSetting = FontSettingStruct();
  FontSettingStruct get tasbihSetting => _tasbihSetting;
  set tasbihSetting(FontSettingStruct value) {
    _tasbihSetting = value;
    prefs.setString('ff_tasbihSetting', value.serialize());
  }

  void updateTasbihSettingStruct(Function(FontSettingStruct) updateFn) {
    updateFn(_tasbihSetting);
    prefs.setString('ff_tasbihSetting', _tasbihSetting.serialize());
  }

  FontSettingStruct _DuasSetting = FontSettingStruct();
  FontSettingStruct get DuasSetting => _DuasSetting;
  set DuasSetting(FontSettingStruct value) {
    _DuasSetting = value;
    prefs.setString('ff_DuasSetting', value.serialize());
  }

  void updateDuasSettingStruct(Function(FontSettingStruct) updateFn) {
    updateFn(_DuasSetting);
    prefs.setString('ff_DuasSetting', _DuasSetting.serialize());
  }

  bool _haptic = false;
  bool get haptic => _haptic;
  set haptic(bool value) {
    _haptic = value;
    prefs.setBool('ff_haptic', value);
  }

  List<HabitItemStruct> _habitTracker = [];
  List<HabitItemStruct> get habitTracker => _habitTracker;
  set habitTracker(List<HabitItemStruct> value) {
    _habitTracker = value;
  }

  void addToHabitTracker(HabitItemStruct value) {
    habitTracker.add(value);
  }

  void removeFromHabitTracker(HabitItemStruct value) {
    habitTracker.remove(value);
  }

  void removeAtIndexFromHabitTracker(int index) {
    habitTracker.removeAt(index);
  }

  void updateHabitTrackerAtIndex(
    int index,
    HabitItemStruct Function(HabitItemStruct) updateFn,
  ) {
    habitTracker[index] = updateFn(_habitTracker[index]);
  }

  void insertAtIndexInHabitTracker(int index, HabitItemStruct value) {
    habitTracker.insert(index, value);
  }

  List<int> _availablePrayerYears = [];
  List<int> get availablePrayerYears => _availablePrayerYears;
  set availablePrayerYears(List<int> value) {
    _availablePrayerYears = value;
    prefs.setStringList(
        'ff_availablePrayerYears', value.map((x) => x.toString()).toList());
  }

  void addToAvailablePrayerYears(int value) {
    availablePrayerYears.add(value);
    prefs.setStringList('ff_availablePrayerYears',
        _availablePrayerYears.map((x) => x.toString()).toList());
  }

  void removeFromAvailablePrayerYears(int value) {
    availablePrayerYears.remove(value);
    prefs.setStringList('ff_availablePrayerYears',
        _availablePrayerYears.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromAvailablePrayerYears(int index) {
    availablePrayerYears.removeAt(index);
    prefs.setStringList('ff_availablePrayerYears',
        _availablePrayerYears.map((x) => x.toString()).toList());
  }

  void updateAvailablePrayerYearsAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    availablePrayerYears[index] = updateFn(_availablePrayerYears[index]);
    prefs.setStringList('ff_availablePrayerYears',
        _availablePrayerYears.map((x) => x.toString()).toList());
  }

  void insertAtIndexInAvailablePrayerYears(int index, int value) {
    availablePrayerYears.insert(index, value);
    prefs.setStringList('ff_availablePrayerYears',
        _availablePrayerYears.map((x) => x.toString()).toList());
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
