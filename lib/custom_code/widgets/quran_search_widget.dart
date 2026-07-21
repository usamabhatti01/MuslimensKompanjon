// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '/index.dart';

enum SearchResultType { surah, ayah }

class SearchResult {
  final SearchResultType type;
  final SurahsStruct? surah;
  final AyahsStruct? ayah;
  final String matchText;

  SearchResult({
    required this.type,
    this.surah,
    this.ayah,
    required this.matchText,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Widget Entry Point
// ─────────────────────────────────────────────────────────────────────────────

class QuranSearchWidget extends StatefulWidget {
  const QuranSearchWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<QuranSearchWidget> createState() => _QuranSearchWidgetState();
}

class _QuranSearchWidgetState extends State<QuranSearchWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<SearchResult> _searchResults = [];
  bool _isSearching = false;

  // Search history
  static const _historyKey = 'quran_search_history';
  List<String> _searchHistory = [];

  // Tips panel
  bool _tipsExpanded = false;

  // Ayah of the day
  AyahsStruct? _ayahOfTheDay;
  SurahsStruct? _surahOfTheDay;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadHistory();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pickAyahOfTheDay();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // ─── Search History ────────────────────────────────────────────────────────

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_historyKey);
    if (raw != null) {
      final List<dynamic> decoded = jsonDecode(raw);
      setState(() {
        _searchHistory = decoded.cast<String>();
      });
    }
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_historyKey, jsonEncode(_searchHistory));
  }

  void _addToHistory(String query) {
    if (query.isEmpty) return;
    setState(() {
      _searchHistory.remove(query);
      _searchHistory.insert(0, query);
      if (_searchHistory.length > 8) {
        _searchHistory = _searchHistory.sublist(0, 8);
      }
    });
    _saveHistory();
  }

  void _removeFromHistory(String query) {
    setState(() {
      _searchHistory.remove(query);
    });
    _saveHistory();
  }

  void _clearHistory() {
    setState(() {
      _searchHistory.clear();
    });
    _saveHistory();
  }

  void _runHistoryQuery(String query) {
    _searchController.text = query;
    _searchController.selection =
        TextSelection.fromPosition(TextPosition(offset: query.length));
    _performSearch();
  }

  // ─── Ayah of the Day ──────────────────────────────────────────────────────

  void _pickAyahOfTheDay() {
    final allAyahs = FFAppState().ayahsList;
    if (allAyahs.isEmpty) return;

    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year)).inDays;
    final index = dayOfYear % allAyahs.length;
    final ayah = allAyahs[index];
    final surah = _getSurahByNumber(ayah.surah);

    setState(() {
      _ayahOfTheDay = ayah;
      _surahOfTheDay = surah;
    });
  }

  // ─── Search Logic ──────────────────────────────────────────────────────────

  void _onSearchChanged() {
    _performSearch();
  }

  bool _isArabic(String text) {
    final RegExp arabicRegExp = RegExp(r'[\u0600-\u06FF]');
    return arabicRegExp.hasMatch(text);
  }

  String _stripDiacritics(String text) {
    final RegExp diacritics =
        RegExp(r'[\u064B-\u0652\u0640\u0670\u06E1\u06D6-\u06ED]');
    return text.replaceAll(diacritics, '');
  }

  String _getSnippet(String text, String query) {
    final int index = text.toLowerCase().indexOf(query.toLowerCase());
    if (index == -1) return text;
    final int start = (index - 25).clamp(0, text.length);
    final int end = (index + query.length + 35).clamp(0, text.length);
    String snippet = text.substring(start, end).trim();
    if (start > 0) snippet = '...$snippet';
    if (end < text.length) snippet = '$snippet...';
    return snippet;
  }

  SurahsStruct? _getSurahByNumber(int number) {
    return FFAppState().surahsList.firstWhereOrNull((e) => e.number == number);
  }

  /// true  → Swedish (default when unset)
  /// false → English only when languageCode is explicitly 'en'
  bool get _isSv => FFAppState().user.languageCode != 'en';

  void _performSearch() {
    final String query = _searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final String normalizedQuery = query.toLowerCase();
    final List<SearchResult> results = [];

    // ── Surah:Ayah direct format e.g. "2:255" ─────────────────────────────
    final RegExp surahAyahRegex = RegExp(r'^(\d+)\s*:\s*(\d+)$');
    final match = surahAyahRegex.firstMatch(normalizedQuery);

    if (match != null) {
      final int surahNum = int.parse(match.group(1)!);
      final int ayahNum = int.parse(match.group(2)!);

      final ayahs = FFAppState()
          .ayahsList
          .where((e) => e.surah == surahNum && e.ayah == ayahNum)
          .toList();
      for (var ayah in ayahs) {
        results.add(SearchResult(
          type: SearchResultType.ayah,
          ayah: ayah,
          surah: _getSurahByNumber(ayah.surah),
          matchText: 'Direct link to verse',
        ));
      }
    } else {
      final int? singleNumber = int.tryParse(normalizedQuery);
      final allAyahs = FFAppState().ayahsList;
      final allSurahs = FFAppState().surahsList;

      // ── Surah jump cards (name search) ──────────────────────────────────
      if (singleNumber != null && singleNumber >= 1 && singleNumber <= 114) {
        final surah = _getSurahByNumber(singleNumber);
        if (surah != null) {
          results.add(SearchResult(
            type: SearchResultType.surah,
            surah: surah,
            matchText: 'Surah #$singleNumber',
          ));
        }
      } else if (singleNumber == null) {
        final matchedSurahs = allSurahs.where((surah) {
          return surah.englishName.toLowerCase().contains(normalizedQuery) ||
              surah.swedishName.toLowerCase().contains(normalizedQuery) ||
              surah.englishTranslation
                  .toLowerCase()
                  .contains(normalizedQuery) ||
              surah.name.contains(normalizedQuery);
        }).toList();

        for (var surah in matchedSurahs) {
          results.add(SearchResult(
            type: SearchResultType.surah,
            surah: surah,
            matchText: surah.englishName,
          ));
        }
      }

      // ── Ayah search ─────────────────────────────────────────────────────
      final isSv = _isSv;

      final filteredAyahs = allAyahs
          .where((ayah) {
            if (singleNumber != null) return ayah.ayah == singleNumber;

            if (_isArabic(query)) {
              final strippedAyahArabic = _stripDiacritics(ayah.arabic);
              final strippedQuery = _stripDiacritics(normalizedQuery);
              return strippedAyahArabic.contains(strippedQuery);
            } else {
              // Search only in the user's selected language
              return isSv
                  ? ayah.swedish.toLowerCase().contains(normalizedQuery)
                  : ayah.english.toLowerCase().contains(normalizedQuery);
            }
          })
          .take(150)
          .toList();

      for (var ayah in filteredAyahs) {
        String snippet = '';
        if (_isArabic(query)) {
          snippet = isSv ? 'Arabisk textmatchning' : 'Arabic text match';
        } else {
          final text = isSv ? ayah.swedish : ayah.english;
          snippet = _getSnippet(text, query);
        }

        results.add(SearchResult(
          type: SearchResultType.ayah,
          ayah: ayah,
          surah: _getSurahByNumber(ayah.surah),
          matchText: snippet,
        ));
      }
    }

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  // ─── Navigation ────────────────────────────────────────────────────────────

  void _navigateToAyah(AyahsStruct ayah) {
    final q = _searchController.text.trim();
    if (q.isNotEmpty) _addToHistory(q);
    QuranPageView.targetAyahNotifier.value = ayah.id;
    Navigator.of(context).pop();
    context.pushNamed(
      KuranPageWidget.routeName,
      queryParameters: {
        'id': serializeParam(ayah.juz, ParamType.int),
        'type': serializeParam(Quran.juz.name, ParamType.String),
        'ayat': serializeParam(ayah.ayah, ParamType.int),
      }.withoutNulls,
    );
  }

  void _navigateToSurah(SurahsStruct surah) {
    final q = _searchController.text.trim();
    if (q.isNotEmpty) _addToHistory(q);
    Navigator.of(context).pop();
    context.pushNamed(
      KuranPageWidget.routeName,
      queryParameters: {
        'id': serializeParam(surah.number, ParamType.int),
        'type': serializeParam(Quran.sura.name, ParamType.String),
      }.withoutNulls,
    );
  }

  void _quickJump(int surahNum, int ayahNum) {
    final ayah = FFAppState()
        .ayahsList
        .firstWhereOrNull((e) => e.surah == surahNum && e.ayah == ayahNum);
    if (ayah != null) {
      _navigateToAyah(ayah);
    } else {
      final surah = _getSurahByNumber(surahNum);
      if (surah != null) _navigateToSurah(surah);
    }
  }

  // ─── Text Highlighting ────────────────────────────────────────────────────

  List<TextSpan> _highlightSpans(String text, String query,
      TextStyle normalStyle, TextStyle highlightStyle) {
    if (query.isEmpty) return [TextSpan(text: text, style: normalStyle)];

    final List<TextSpan> spans = [];
    final String lowercaseText = text.toLowerCase();
    final String lowercaseQuery = query.toLowerCase();

    int start = 0;
    int index = lowercaseText.indexOf(lowercaseQuery, start);

    while (index != -1) {
      if (index > start) {
        spans.add(
            TextSpan(text: text.substring(start, index), style: normalStyle));
      }
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: highlightStyle,
      ));
      start = index + query.length;
      index = lowercaseText.indexOf(lowercaseQuery, start);
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: normalStyle));
    }

    return spans;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final theme = FlutterFlowTheme.of(context);
    final isQueryEmpty = _searchController.text.trim().isEmpty;

    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12.0, bottom: 4.0),
              width: 40.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: theme.alternate,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 16.0, 4.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isSv ? 'Sök i Koranen' : 'Search Quran',
                        style: theme.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryText,
                        ),
                      ),
                      Text(
                        _isSv
                            ? 'Sök på sura, arabiska, eller 2:255'
                            : 'Search by keyword, Arabic text, or 2:255',
                        style: theme.labelMedium.copyWith(
                          color: theme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, color: theme.secondaryText),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // Search field
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Container(
              decoration: BoxDecoration(
                color: theme.primaryBackground,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: theme.alternate, width: 1.0),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                style: theme.bodyMedium,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  final q = value.trim();
                  if (q.isNotEmpty) _addToHistory(q);
                },
                decoration: InputDecoration(
                  hintText: _isSv
                      ? 'Suranamn, sökord eller 2:255...'
                      : 'Surah name, keyword, or 2:255...',
                  hintStyle:
                      theme.labelMedium.copyWith(color: theme.secondaryText),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child:
                        Icon(Icons.search_rounded, color: theme.secondaryText),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear_rounded,
                              color: theme.secondaryText, size: 18.0),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 8.0),
                ),
              ),
            ),
          ),

          const SizedBox(height: 4.0),
          Divider(height: 1.0, thickness: 1.0, color: theme.alternate),

          // Main content
          Expanded(
            child: Builder(builder: (context) {
              if (_isSearching) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.primary,
                    strokeWidth: 2.0,
                  ),
                );
              }

              if (isQueryEmpty) {
                return _buildDashboard(theme);
              }

              if (_searchResults.isEmpty) {
                return _buildEmptyState(theme);
              }

              return ListView.separated(
                itemCount: _searchResults.length,
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 32.0),
                separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                itemBuilder: (context, index) =>
                    _buildSearchResultCard(_searchResults[index], theme),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DASHBOARD (shown when search is empty)
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildDashboard(FlutterFlowTheme theme) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 32.0),
      children: [
        // ── Search History ────────────────────────────────────────────────
        if (_searchHistory.isNotEmpty) ...[
          _buildSectionHeader(
            theme,
            icon: Icons.history_rounded,
            title: _isSv ? 'Senaste sökningar' : 'Recent Searches',
            trailing: TextButton(
              onPressed: _clearHistory,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                _isSv ? 'Rensa alla' : 'Clear all',
                style: theme.labelSmall.copyWith(color: theme.secondaryText),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children:
                _searchHistory.map((q) => _buildHistoryChip(q, theme)).toList(),
          ),
          const SizedBox(height: 24.0),
        ],

        // ── Ayah of the Day ───────────────────────────────────────────────
        _buildSectionHeader(
          theme,
          icon: Icons.auto_awesome_rounded,
          title: _isSv ? 'Dagens vers' : 'Ayah of the Day',
        ),
        const SizedBox(height: 8.0),
        _buildAyahOfTheDayCard(theme),
        const SizedBox(height: 24.0),

        // ── Quick Links ───────────────────────────────────────────────────
        _buildSectionHeader(
          theme,
          icon: Icons.bolt_rounded,
          title: _isSv ? 'Snabblänkar' : 'Quick Links',
        ),
        const SizedBox(height: 8.0),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 2.4,
          ),
          children: [
            _buildQuickLinkCard(
                'Al-Fatihah',
                _isSv ? 'Öppningen' : 'The Opening',
                'الفاتحة',
                1,
                1,
                Icons.menu_book_rounded,
                theme),
            _buildQuickLinkCard(
                'Ayat al-Kursi',
                _isSv ? '2:255 – Tronversen' : '2:255 – The Throne Verse',
                'آية الكرسي',
                2,
                255,
                Icons.shield_rounded,
                theme),
            _buildQuickLinkCard(
                'Ya-Sin',
                _isSv ? 'Koranens hjärta' : 'Heart of the Quran',
                'يس',
                36,
                1,
                Icons.favorite_rounded,
                theme),
            _buildQuickLinkCard(
                'Al-Mulk',
                _isSv ? 'Herraväldet' : 'The Sovereignty',
                'الملك',
                67,
                1,
                Icons.auto_awesome_rounded,
                theme),
            _buildQuickLinkCard(
                'Al-Kahf',
                _isSv ? 'Fredagssura' : 'Friday Surah',
                'الكهف',
                18,
                1,
                Icons.wb_sunny_rounded,
                theme),
            _buildQuickLinkCard(
                'Al-Ikhlas',
                _isSv ? 'Den rena tron' : 'Pure Faith',
                'الإخلاص',
                112,
                1,
                Icons.star_rounded,
                theme),
          ],
        ),
        const SizedBox(height: 24.0),

        // ── Search Tips ───────────────────────────────────────────────────
        _buildSearchTipsPanel(theme),
      ],
    );
  }

  Widget _buildSectionHeader(
    FlutterFlowTheme theme, {
    required IconData icon,
    required String title,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16.0, color: theme.primary),
        const SizedBox(width: 6.0),
        Text(
          title,
          style: theme.titleSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.primaryText,
          ),
        ),
        const Spacer(),
        if (trailing != null) trailing,
      ],
    );
  }

  // ── History Chip ─────────────────────────────────────────────────────────

  Widget _buildHistoryChip(String query, FlutterFlowTheme theme) {
    return GestureDetector(
      onTap: () => _runHistoryQuery(query),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
        decoration: BoxDecoration(
          color: theme.primaryBackground,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: theme.alternate, width: 1.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history_rounded, size: 14.0, color: theme.secondaryText),
            const SizedBox(width: 6.0),
            Text(
              query,
              style: theme.bodySmall.copyWith(color: theme.primaryText),
            ),
            const SizedBox(width: 6.0),
            GestureDetector(
              onTap: () => _removeFromHistory(query),
              child: Icon(Icons.close_rounded,
                  size: 13.0, color: theme.secondaryText),
            ),
          ],
        ),
      ),
    );
  }

  // ── Ayah of the Day Card ──────────────────────────────────────────────────

  Widget _buildAyahOfTheDayCard(FlutterFlowTheme theme) {
    if (_ayahOfTheDay == null) {
      return Container(
        height: 120.0,
        decoration: BoxDecoration(
          color: theme.primaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Text(_isSv ? 'Laddar...' : 'Loading...',
              style: theme.labelMedium),
        ),
      );
    }

    final ayah = _ayahOfTheDay!;
    final surah = _surahOfTheDay;

    // Pick translation based on user's selected language
    String translation = '';
    if (_isSv && ayah.swedish.trim().isNotEmpty) {
      translation = ayah.swedish;
    } else if (!_isSv && ayah.english.trim().isNotEmpty) {
      translation = ayah.english;
    } else if (ayah.swedish.trim().isNotEmpty) {
      translation = ayah.swedish; // fallback
    } else {
      translation = ayah.english;
    }

    final snippet = translation.length > 120
        ? '${translation.substring(0, 120)}...'
        : translation;

    return GestureDetector(
      onTap: () => _navigateToAyah(ayah),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.primary.withOpacity(0.85),
              theme.primary.withOpacity(0.55),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.primary.withOpacity(0.25),
              blurRadius: 16.0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative circle
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -10,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          surah != null
                              ? '${surah.englishName} • ${ayah.surah}:${ayah.ayah}'
                              : '${ayah.surah}:${ayah.ayah}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.white70, size: 13.0),
                    ],
                  ),
                  const SizedBox(height: 12.0),

                  // Arabic text
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ayah.arabic,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.scheherazadeNew(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        height: 1.8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Translation snippet
                  if (snippet.isNotEmpty)
                    Text(
                      snippet,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Quick Link Card ───────────────────────────────────────────────────────

  Widget _buildQuickLinkCard(
    String title,
    String subtitle,
    String arabicName,
    int surah,
    int ayah,
    IconData icon,
    FlutterFlowTheme theme,
  ) {
    return InkWell(
      onTap: () => _quickJump(surah, ayah),
      borderRadius: BorderRadius.circular(14.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: theme.primaryBackground,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: theme.alternate, width: 1.0),
        ),
        child: Row(
          children: [
            Container(
              width: 34.0,
              height: 34.0,
              decoration: BoxDecoration(
                color: theme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(9.0),
              ),
              child: Icon(icon, color: theme.primary, size: 17.0),
            ),
            const SizedBox(width: 9.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: theme.labelSmall.copyWith(
                      color: theme.secondaryText,
                      fontSize: 9.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Search Tips Panel ─────────────────────────────────────────────────────

  Widget _buildSearchTipsPanel(FlutterFlowTheme theme) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _tipsExpanded = !_tipsExpanded),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: theme.primaryBackground,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: theme.alternate, width: 1.0),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline_rounded,
                    size: 16.0, color: theme.primary),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _isSv ? 'Söktips' : 'Search Tips',
                    style: theme.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.primaryText,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _tipsExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                      size: 18.0, color: theme.secondaryText),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          child: _tipsExpanded
              ? Container(
                  margin: const EdgeInsets.only(top: 4.0),
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: theme.primaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: theme.alternate, width: 1.0),
                  ),
                  child: Column(
                    children: [
                      _buildTipRow(
                          theme,
                          '2:255',
                          _isSv
                              ? 'Hoppa direkt till sura 2, vers 255 (Tronversen)'
                              : 'Jump directly to Surah 2, Ayah 255 (Ayat al-Kursi)'),
                      _buildTipRow(
                          theme,
                          _isSv ? 'Arabisk text' : 'Arabic text',
                          _isSv
                              ? 'Skriv arabiska tecken för att söka i originaltexten'
                              : 'Type Arabic characters to search in the original text'),
                      _buildTipRow(
                          theme,
                          _isSv ? 'Engelska / Svenska' : 'English / Swedish',
                          _isSv
                              ? 'Skriv sökord för att söka i översättningar'
                              : 'Type any keyword to search across translations'),
                      _buildTipRow(
                          theme,
                          _isSv ? 'Suranamn' : 'Surah name',
                          _isSv
                              ? 't.ex. "Baqara", "Al-Kahf" — hoppar till suran'
                              : 'e.g. "Baqara", "Al-Kahf" — jumps to the surah'),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildTipRow(FlutterFlowTheme theme, String code, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: theme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              code,
              style: theme.labelSmall.copyWith(
                color: theme.primary,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              desc,
              style: theme.labelSmall.copyWith(color: theme.secondaryText),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEARCH RESULTS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildEmptyState(FlutterFlowTheme theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                color: theme.primaryBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.search_off_rounded,
                  size: 36.0, color: theme.secondaryText),
            ),
            const SizedBox(height: 16.0),
            Text(
              _isSv ? 'Inga resultat hittades' : 'No results found',
              style: theme.titleSmall.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              _isSv
                  ? 'Prova ett annat sökord, suranamn, eller formatet 2:255.'
                  : 'Try a different keyword, surah name, or use the 2:255 format.',
              textAlign: TextAlign.center,
              style: theme.labelMedium.copyWith(color: theme.secondaryText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultCard(SearchResult item, FlutterFlowTheme theme) {
    // ── Surah jump card ──────────────────────────────────────────────────────
    if (item.type == SearchResultType.surah && item.surah != null) {
      final surah = item.surah!;
      return InkWell(
        onTap: () => _navigateToSurah(surah),
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            borderRadius: BorderRadius.circular(14.0),
            border:
                Border.all(color: theme.primary.withOpacity(0.35), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: theme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${surah.number}',
                  style: theme.bodyMedium.copyWith(
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.englishName,
                      style: theme.bodyMedium
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${surah.englishTranslation} • ${surah.totalVerses} verses',
                      style:
                          theme.labelSmall.copyWith(color: theme.secondaryText),
                    ),
                  ],
                ),
              ),
              Text(
                surah.name,
                style: GoogleFonts.scheherazadeNew(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: theme.primary,
                ),
              ),
              const SizedBox(width: 8.0),
              Icon(Icons.chevron_right_rounded,
                  color: theme.secondaryText, size: 18.0),
            ],
          ),
        ),
      );
    }

    // ── Ayah result card ─────────────────────────────────────────────────────
    if (item.type == SearchResultType.ayah &&
        item.ayah != null &&
        item.surah != null) {
      final ayah = item.ayah!;
      final surah = item.surah!;
      final query = _searchController.text.trim();

      return InkWell(
        onTap: () => _navigateToAyah(ayah),
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: theme.alternate, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${surah.englishName} • ${ayah.surah}:${ayah.ayah}',
                      style: theme.labelSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primary,
                      ),
                    ),
                  ),
                  Text(
                    'Juz ${ayah.juz}',
                    style:
                        theme.labelSmall.copyWith(color: theme.secondaryText),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Arabic text
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  ayah.arabic,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.scheherazadeNew(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                    height: 1.9,
                    color: theme.primaryText,
                  ),
                ),
              ),

              // Show translation in the user's selected language only
              if (_isSv && ayah.swedish.trim().isNotEmpty) ...[
                const SizedBox(height: 8.0),
                Divider(height: 1.0, color: theme.alternate),
                const SizedBox(height: 8.0),
                RichText(
                  text: TextSpan(
                    children: _highlightSpans(
                      ayah.swedish,
                      query,
                      theme.bodySmall
                          .copyWith(color: theme.primaryText, height: 1.5),
                      theme.bodySmall.copyWith(
                        color: theme.primary,
                        fontWeight: FontWeight.bold,
                        backgroundColor: theme.primary.withOpacity(0.1),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],

              if (!_isSv && ayah.english.trim().isNotEmpty) ...[
                const SizedBox(height: 6.0),
                RichText(
                  text: TextSpan(
                    children: _highlightSpans(
                      ayah.english,
                      query,
                      theme.labelSmall.copyWith(
                          color: theme.secondaryText,
                          fontStyle: FontStyle.italic,
                          height: 1.5),
                      theme.labelSmall.copyWith(
                        color: theme.primary,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        backgroundColor: theme.primary.withOpacity(0.1),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
