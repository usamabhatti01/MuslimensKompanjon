import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PrayerAssetResolver {
  PrayerAssetResolver._();

  static List<String>? _cachedAssets;

  static String toNfd(String input) {
    const decomposed = <String, String>{
      'å': 'a\u030A',
      'ä': 'a\u0308',
      'ö': 'o\u0308',
      'é': 'e\u0301',
      'è': 'e\u0300',
      'ü': 'u\u0308',
      'Å': 'A\u030A',
      'Ä': 'A\u0308',
      'Ö': 'O\u0308',
      'É': 'E\u0301',
    };
    var result = input;
    decomposed.forEach((composed, decomposed) {
      result = result.replaceAll(composed, decomposed);
    });
    return result;
  }

  static bool _fileNamesMatch(String a, String b) {
    final left = a.toLowerCase();
    final right = b.toLowerCase();
    if (left == right) return true;
    if (toNfd(left) == right) return true;
    if (left == toNfd(right)) return true;
    if (toNfd(left) == toNfd(right)) return true;
    return false;
  }

  static Future<List<String>> _allAssets() async {
    if (_cachedAssets != null) return _cachedAssets!;
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    _cachedAssets = manifest.listAssets();
    return _cachedAssets!;
  }

  static Future<String?> resolvePath(String cityName, int year) async {
    final slug = cityName.trim().toLowerCase();
    final fileName = '${slug}_$year.json';
    final fileNameNfd = toNfd(fileName);
    final assets = await _allAssets();

    final directPaths = <String>[
      'assets/jsons/$year/$fileName',
      'assets/jsons/$year/$fileNameNfd',
      'assets/jsons/$fileName',
      'assets/jsons/$fileNameNfd',
    ];

    for (final path in directPaths) {
      if (assets.contains(path)) return path;
    }

    String? rootFallback;
    for (final asset in assets) {
      if (!asset.startsWith('assets/jsons/')) continue;
      if (!asset.endsWith('_$year.json')) continue;
      final base = asset.split('/').last;
      if (!_fileNamesMatch(base, fileName)) continue;

      if (asset.contains('/$year/')) return asset;
      rootFallback ??= asset;
    }

    return rootFallback;
  }

  static Future<String> loadJsonString(String cityName, int year) async {
    final path = await resolvePath(cityName, year);
    if (path == null) {
      throw FlutterError(
        'No prayer JSON asset for "$cityName" ($year).',
      );
    }
    return rootBundle.loadString(path);
  }

  static void clearCache() => _cachedAssets = null;
}
