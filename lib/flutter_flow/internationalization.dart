import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['sv', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? svText = '',
    String? enText = '',
  }) =>
      [svText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // OnBoarding_01
  {
    'nx8iom7k': {
      'sv':
          'Your daily companion for a richer Muslim life – with everything from the Quran with arabic/swedish/english text and audio, the MK video channel, and Dhikr to information about Islam. The app also includes essential tools such as prayer times, Hijri calendar, Qibla, a to-do list, and a map of Sweden\'s mosques.',
      'en': '',
    },
    'rvpsptrn': {
      'sv': 'The Quran',
      'en': '',
    },
    'joihiot8': {
      'sv': 'Arabic/Swedish/English text and audio.',
      'en': '',
    },
    'maa4ofyz': {
      'sv': 'Information about Islam',
      'en': '',
    },
    'wfyj726d': {
      'sv': 'Learn the basics of Islam.',
      'en': '',
    },
    'dmu2s25s': {
      'sv': 'MK Video Channel',
      'en': '',
    },
    'dp7yclz4': {
      'sv': 'Inspirational and educational videos.',
      'en': '',
    },
    'azey4eph': {
      'sv': 'Prayer Times & Tools',
      'en': '',
    },
    'a8ohkp7l': {
      'sv': 'Prayer times, Qibla, Dhikr, and to-do list.',
      'en': '',
    },
    'bbdbyrlr': {
      'sv': 'Hijri Calendar & Maps',
      'en': '',
    },
    'jl9wgdwf': {
      'sv': 'Important dates and map of mosques.',
      'en': '',
    },
    'vdnlcr9h': {
      'sv': 'Get Started',
      'en': '',
    },
    '64uo21dt': {
      'sv': 'Home',
      'en': '',
    },
  },
  // OnBoarding_02
  {
    'yl1786un': {
      'sv': 'Location',
      'en': '',
    },
    'k7h01c7m': {
      'sv':
          'To provide accurate prayer times, the app needs to know your location.',
      'en': '',
    },
    'c73jwsb7': {
      'sv': 'Use my current location',
      'en': '',
    },
    'e5ae3lwy': {
      'sv': 'Select location manually',
      'en': '',
    },
    'e8lqdzus': {
      'sv': 'Home',
      'en': '',
    },
  },
  // OnBoarding_04
  {
    'ihs7k9dt': {
      'sv': 'Prayer Notifications',
      'en': '',
    },
    'urwz9ora': {
      'sv': 'Never Miss a prayer!',
      'en': '',
    },
    'mngumizw': {
      'sv':
          'Choose which times you want to \nreceive alerts and notifications for.',
      'en': '',
    },
    'a2usqzrp': {
      'sv':
          'You can select different adhan voices and\n options later in the app settings.',
      'en': '',
    },
    'wlfhuhub': {
      'sv': 'Enable Notifications',
      'en': '',
    },
    's060smtr': {
      'sv': 'Skip',
      'en': '',
    },
    'qf4c76e9': {
      'sv': 'Home',
      'en': '',
    },
  },
  // Home
  {
    'z0nfmsqo': {
      'sv': 'Muslimens Kompanjon',
      'en': '',
    },
    '1rmnuxcp': {
      'sv': 'Select...',
      'en': '',
    },
    'pateb44t': {
      'sv': 'Search...',
      'en': '',
    },
    'egooxlu9': {
      'sv': 'MK Channel',
      'en': '',
    },
    'etzm8l1t': {
      'sv': 'Recommended Content',
      'en': '',
    },
    'errzcqel': {
      'sv': 'Categories',
      'en': '',
    },
    'y57a81yv': {
      'sv': 'Home',
      'en': '',
    },
  },
  // TashbihCounter
  {
    'qtlrii0r': {
      'sv': 'Tap circle to count',
      'en': '',
    },
    'pmrczjgc': {
      'sv': 'Reset',
      'en': '',
    },
    'nfghvyzb': {
      'sv': 'Next Zikr',
      'en': '',
    },
    '71z9y9uh': {
      'sv': 'Daily Goal',
      'en': '',
    },
    'c2wsw4qa': {
      'sv': '/',
      'en': '',
    },
    'uq59s6ih': {
      'sv': 'Session',
      'en': '',
    },
    'ycfamops': {
      'sv': 'Remember Allah often for peace of heart.',
      'en': '',
    },
    'gfpevler': {
      'sv': 'Home',
      'en': '',
    },
  },
  // QiblaFinder
  {
    '1tdbu0h2': {
      'sv': 'Qibla',
      'en': '',
    },
  },
  // YoutubeFeed
  {
    '69ylbww1': {
      'sv': 'YouTube Feed',
      'en': '',
    },
    'ynkvf2gu': {
      'sv': 'View All',
      'en': '',
    },
    'f8b6mh5b': {
      'sv': 'YouTube Feed',
      'en': '',
    },
    'zapo2emg': {
      'sv': 'View All',
      'en': '',
    },
    '7mall0cg': {
      'sv': 'YouTube Feed',
      'en': '',
    },
    'y0npzuhu': {
      'sv': 'View All',
      'en': '',
    },
    'kw20ynzo': {
      'sv': 'Home',
      'en': '',
    },
  },
  // Adhkar
  {
    '7uzhg2z5': {
      'sv': 'Adhkar',
      'en': '',
    },
    'd1wi5lcc': {
      'sv': 'Adhkar',
      'en': '',
    },
    'y5atdrmd': {
      'sv': 'Morning\nAdhkar',
      'en': '',
    },
    'cb1pwk76': {
      'sv': 'Evening\nAdhkar',
      'en': '',
    },
    'lwqvydl6': {
      'sv': 'Tasbih',
      'en': '',
    },
    'jguwpo06': {
      'sv': 'Names\nof Allah',
      'en': '',
    },
    'lxb3k9nj': {
      'sv': 'Supplicati-\nons (Dua)',
      'en': '',
    },
    '9v555u67': {
      'sv': 'Adhkar',
      'en': '',
    },
  },
  // MorningAdhkar
  {
    '7q1y15m7': {
      'sv': 'Home',
      'en': '',
    },
  },
  // Tasbih
  {
    '68pvqi4h': {
      'sv': 'Tasbih',
      'en': '',
    },
    '8ebjar5s': {
      'sv': 'Tasbih',
      'en': '',
    },
    'aaprlfnp': {
      'sv': 'Home',
      'en': '',
    },
  },
  // AllahNames
  {
    '6l76dcws': {
      'sv': 'Home',
      'en': '',
    },
  },
  // EveningAdhkar
  {
    'h29637l5': {
      'sv': 'Home',
      'en': '',
    },
  },
  // SupplicationsDua
  {
    '267ulmy2': {
      'sv': 'Home',
      'en': '',
    },
  },
  // AboutIslam
  {
    '5xodvrat': {
      'sv': 'Guiding reminders',
      'en': '',
    },
    'og6bb6pf': {
      'sv': 'Home',
      'en': '',
    },
  },
  // AboutIslamDetailsPage
  {
    'mgolrpfb': {
      'sv': 'Home',
      'en': '',
    },
  },
  // Notification
  {
    'xu2eyxv3': {
      'sv': 'Never Miss a prayer!',
      'en': '',
    },
    'zfw0kuao': {
      'sv':
          'Choose which times you want to \nreceive alerts and notifications for.',
      'en': '',
    },
    '703n8kne': {
      'sv':
          'You can select different adhan voices and\n options later in the app settings.',
      'en': '',
    },
    'gwrkyhlk': {
      'sv': 'Enable Notifications',
      'en': '',
    },
    'tmqohi5q': {
      'sv': 'Home',
      'en': '',
    },
  },
  // Setting
  {
    'mtollg4l': {
      'sv': 'GENERAL',
      'en': '',
    },
    'fncdf82o': {
      'sv': 'Language',
      'en': '',
    },
    'xmrsw0q5': {
      'sv': 'English / Swedish',
      'en': '',
    },
    'wenh6r45': {
      'sv': 'Dark Mode',
      'en': '',
    },
    'tfuixbmk': {
      'sv': 'Enable night theme',
      'en': '',
    },
    'g5vea3ux': {
      'sv': 'Select...',
      'en': '',
    },
    'e8tbonco': {
      'sv': 'Search...',
      'en': '',
    },
    'tcsya18m': {
      'sv': 'NOTIFICATIONS',
      'en': '',
    },
    'vqurv3tv': {
      'sv': 'Prayer Alerts',
      'en': '',
    },
    '2wpr27rj': {
      'sv': 'Adhan & reminders',
      'en': '',
    },
    '1ikyhdgs': {
      'sv': 'ABOUT',
      'en': '',
    },
    'li4rumqj': {
      'sv': 'About App',
      'en': '',
    },
    '6j7r761q': {
      'sv': 'App Verison',
      'en': '',
    },
    'a790uuls': {
      'sv': 'Rate App',
      'en': '',
    },
    'fltp0ov1': {
      'sv': 'Rate on PlayStore',
      'en': '',
    },
    'qpk4tfzr': {
      'sv': 'Setting',
      'en': '',
    },
  },
  // InPage2
  {
    '25yjfj7o': {
      'sv': 'Prayer Timetable',
      'en': '',
    },
    'jxg4we4v': {
      'sv': 'Monthly Schedule',
      'en': '',
    },
    '7nwggw3o': {
      'sv': 'London',
      'en': '',
    },
    '0xun7xeu': {
      'sv': 'London',
      'en': '',
    },
    '2vcvdjfa': {
      'sv': 'City',
      'en': '',
    },
    '2e0n40oi': {
      'sv': 'London',
      'en': '',
    },
    '956jezra': {
      'sv': 'New York',
      'en': '',
    },
    'z2mohm0c': {
      'sv': 'Dubai',
      'en': '',
    },
    'p0k729zo': {
      'sv': 'Riyadh',
      'en': '',
    },
    'hc7pdwwr': {
      'sv': 'Istanbul',
      'en': '',
    },
    '2z77y2od': {
      'sv': 'October',
      'en': '',
    },
    'qg6faloa': {
      'sv': 'January',
      'en': '',
    },
    '474k6ayw': {
      'sv': 'Month',
      'en': '',
    },
    'qqqb4vth': {
      'sv': 'January',
      'en': '',
    },
    'gs8rzxja': {
      'sv': 'February',
      'en': '',
    },
    'zttf8l45': {
      'sv': 'March',
      'en': '',
    },
    '0rddej77': {
      'sv': 'April',
      'en': '',
    },
    'eq9kcdpu': {
      'sv': 'May',
      'en': '',
    },
    'pnjyu0kq': {
      'sv': 'June',
      'en': '',
    },
    'jt8usf6a': {
      'sv': 'July',
      'en': '',
    },
    'sgzgi30a': {
      'sv': 'August',
      'en': '',
    },
    'n44jj0ip': {
      'sv': 'September',
      'en': '',
    },
    'ua2tfdfd': {
      'sv': 'October',
      'en': '',
    },
    'c1d7qpwr': {
      'sv': 'November',
      'en': '',
    },
    '5smanrvz': {
      'sv': 'December',
      'en': '',
    },
    'g2sydhk4': {
      'sv': '2024',
      'en': '',
    },
    'y4wcvix4': {
      'sv': '2023',
      'en': '',
    },
    '4zwkdixz': {
      'sv': 'Year',
      'en': '',
    },
    's8400o9t': {
      'sv': '2023',
      'en': '',
    },
    'lawlxep3': {
      'sv': '2024',
      'en': '',
    },
    'txnq68n5': {
      'sv': '2025',
      'en': '',
    },
  },
  // IslamicCalender
  {
    'jb6vj8mf': {
      'sv': 'Select...',
      'en': '',
    },
    'z1xmx925': {
      'sv': 'Search...',
      'en': '',
    },
    'vtv6tua6': {
      'sv': 'Option 1',
      'en': '',
    },
    'ym3kko31': {
      'sv': 'Option 2',
      'en': '',
    },
    '7sdze5fw': {
      'sv': 'Option 3',
      'en': '',
    },
    '32zln7lu': {
      'sv': 'Månads bönetider',
      'en': '',
    },
    'nhbj8ppo': {
      'sv': 'Select Month',
      'en': '',
    },
    'd3299ui1': {
      'sv': 'Search...',
      'en': '',
    },
    '10zy4z5d': {
      'sv': 'Option 1',
      'en': '',
    },
    'v0xdvvxi': {
      'sv': 'Option 2',
      'en': '',
    },
    'u8yuqx3j': {
      'sv': 'Option 3',
      'en': '',
    },
    'u41togof': {
      'sv': 'Select Year',
      'en': '',
    },
    'br9of2cu': {
      'sv': 'Search...',
      'en': '',
    },
    'gt9z67j0': {
      'sv': '2026',
      'en': '',
    },
    'tcpi989l': {
      'sv': '2027',
      'en': '',
    },
    'nq1nh4qp': {
      'sv': 'Home',
      'en': '',
    },
  },
  // OnBoarding_00
  {
    'tp7zc6ya': {
      'sv': 'Choose Language',
      'en': '',
    },
    '7c2axt1z': {
      'sv':
          'The app follows your phone\'s language automatically. You can change this later in settings.',
      'en': '',
    },
    '76260gef': {
      'sv': 'Continue',
      'en': '',
    },
    'h7wupplt': {
      'sv': 'Home',
      'en': '',
    },
  },
  // LoadData
  {
    'x67u2ja9': {
      'sv': 'Home',
      'en': '',
    },
  },
  // RatingPage
  {
    '0hbhjqqz': {
      'sv': 'Enjoying MuslimensKompanjon?',
      'en': '',
    },
    'qp32ewht': {
      'sv': 'Your feedback helps us improve the experience for the Ummah.',
      'en': '',
    },
    '66z8t0gc': {
      'sv': 'Tap to rate',
      'en': '',
    },
    'tld60ncz': {
      'sv': 'What do you like most?',
      'en': '',
    },
    'ov0frsyq': {
      'sv': 'Additional comments (optional)',
      'en': '',
    },
    'deu9y9jy': {
      'sv': 'TextField',
      'en': '',
    },
    'zp1dfurw': {
      'sv': 'Send',
      'en': '',
    },
    '5izqt0k8': {
      'sv': 'Your feedback is anonymous and secure',
      'en': '',
    },
  },
  // AboutPage
  {
    'v24rdvb0': {
      'sv': 'MuslimensKompanjon',
      'en': '',
    },
    'hp5noamc': {
      'sv': 'Version 1.2.0',
      'en': '',
    },
    'u60ethy3': {
      'sv': 'Our Mission',
      'en': '',
    },
    'aosgszi8': {
      'sv':
          'MuslimensKompanjon is dedicated to providing a seamless, ad-free experience for Muslims worldwide. Our goal is to blend modern technology with spiritual necessity, helping you stay connected to your faith wherever you are.',
      'en': '',
    },
    'v29kvzub': {
      'sv': 'Key Features',
      'en': '',
    },
    'opjnggcv': {
      'sv': 'Connect With Us',
      'en': '',
    },
    '2up1j1ny': {
      'sv': 'Support the Project',
      'en': '',
    },
    'g3mertf2': {
      'sv':
          'This app is developed as Sadaqah Jariyah. If you find it beneficial, please keep the developers in your Duas.',
      'en': '',
    },
    'jqvtshzb': {
      'sv': 'Made with ❤️ for the Ummah',
      'en': '',
    },
    'wx631s0z': {
      'sv': '© 2024 MuslimensKompanjon Team',
      'en': '',
    },
  },
  // OnBoarding_03
  {
    'zswc8wda': {
      'sv': 'Search Location',
      'en': '',
    },
    'wb3ixwl4': {
      'sv': 'Search city... ',
      'en': '',
    },
    '4wb899h8': {
      'sv': '',
      'en': '',
    },
    '610ohxtp': {
      'sv': 'Confirm ',
      'en': '',
    },
  },
  // SelectLanguage
  {
    'j592cc89': {
      'sv': 'Välj språk',
      'en': '',
    },
    '20n2l1zk': {
      'sv': 'Choose language',
      'en': '',
    },
    'b5evds53': {
      'sv':
          'Appen följer ditt telefonspråk automatiskt. Du\nkan ändra detta senare i inställningarna.',
      'en': '',
    },
    'kqunxrd7': {
      'sv': 'Fortsätt',
      'en': '',
    },
  },
  // LanguageSelector
  {
    'q15589ax': {
      'sv': '',
      'en': '',
    },
    'i2r73lj1': {
      'sv': '',
      'en': '',
    },
  },
  // ArabicHeadingAndTranslation
  {
    'v45ugzwi': {
      'sv': 'Translation: ',
      'en': '',
    },
  },
  // NameMeaningPopup
  {
    'fo35xndn': {
      'sv': 'Closed',
      'en': '',
    },
  },
  // PrayerTimeRow
  {
    'lmx7qwl4': {
      'sv': 'TODAY',
      'en': '',
    },
  },
  // Miscellaneous
  {
    'y5119vn0': {
      'sv': 'Button',
      'en': '',
    },
    'hxaz1ytg': {
      'sv': 'Button',
      'en': '',
    },
    '2pu6dotg': {
      'sv': 'Select...',
      'en': '',
    },
    '8c9ekv6q': {
      'sv': 'Search...',
      'en': '',
    },
    '9s0ldm55': {
      'sv': 'Option 1',
      'en': '',
    },
    'ewk9tk4r': {
      'sv': 'Option 2',
      'en': '',
    },
    'bqknxwhf': {
      'sv': 'Option 3',
      'en': '',
    },
    'ucwl3zy2': {
      'sv': '',
      'en': '',
    },
    'notifperm': {
      'sv': 'We need permission to send you prayer time reminders',
      'en': '',
    },
    'qgsw96fl': {
      'sv': '',
      'en': '',
    },
    '6ujl58cm': {
      'sv': '',
      'en': '',
    },
    'p9yp0d0x': {
      'sv': '',
      'en': '',
    },
    'iwndvbmw': {
      'sv': '',
      'en': '',
    },
    '3k209bob': {
      'sv': '',
      'en': '',
    },
    'cgt29ee5': {
      'sv': '',
      'en': '',
    },
    'em3ak4ju': {
      'sv': '',
      'en': '',
    },
    'csesyaxz': {
      'sv': '',
      'en': '',
    },
    'gxx5133c': {
      'sv': '',
      'en': '',
    },
    'n4kgdf69': {
      'sv': '',
      'en': '',
    },
    'por2u73o': {
      'sv': '',
      'en': '',
    },
    '8n49pqhi': {
      'sv': '',
      'en': '',
    },
    'r33g7qa5': {
      'sv': '',
      'en': '',
    },
    'e13z4xp2': {
      'sv': '',
      'en': '',
    },
    'zww6ss0e': {
      'sv': '',
      'en': '',
    },
    '7bk1ab3c': {
      'sv': '',
      'en': '',
    },
    'gwsi8pjq': {
      'sv': '',
      'en': '',
    },
    '8rf3vrle': {
      'sv': '',
      'en': '',
    },
    'f2thbeds': {
      'sv': '',
      'en': '',
    },
    'a4tjxrol': {
      'sv': '',
      'en': '',
    },
    'js7bap0d': {
      'sv': '',
      'en': '',
    },
    '1t9xgbbb': {
      'sv': '',
      'en': '',
    },
    'sqd1obdc': {
      'sv': '',
      'en': '',
    },
    'vih2v0cp': {
      'sv': '',
      'en': '',
    },
    'gex3laap': {
      'sv': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
