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

import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:provider/provider.dart';

class QuranPageView extends StatefulWidget {
  const QuranPageView({
    super.key,
    this.width,
    this.height,
    required this.ayahsList,
    this.currentAyat,
  });

  final double? width;
  final double? height;
  final List<AyahsStruct> ayahsList;
  final int? currentAyat;

  static final ValueNotifier<String?> targetAyahNotifier =
      ValueNotifier<String?>(null);

  @override
  State<QuranPageView> createState() => _QuranPageViewState();
}

class _QuranPageViewState extends State<QuranPageView> {
  // Audio Player variables
  late ap.AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _playbackSpeed = 1.0;

  // Stream Subscriptions
  StreamSubscription<Duration>? _durSub;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<ap.PlayerState>? _stateSub;

  // Widget active states
  int? _activeHighlightIndex;
  int? _currentPlayingIndex;
  bool _isAutoplayActive = false;
  bool _isPlayerVisible = false;
  bool _hasScrolledToCurrentAyat = false;
  int _scrollSessionId = 0;

  // Scroll mapping
  final Map<int, GlobalKey> _ayahKeys = {};
  late ScrollController _scrollController;

  GlobalKey _getKey(int index) {
    return _ayahKeys.putIfAbsent(index, () => GlobalKey());
  }

  // Get sorted list of ayahs based on "surah:ayah" id format numerically
  List<AyahsStruct> get _sortedAyahs {
    final list = List<AyahsStruct>.from(widget.ayahsList);
    list.sort((a, b) {
      try {
        final partsA = a.id.split(':');
        final partsB = b.id.split(':');
        if (partsA.length == 2 && partsB.length == 2) {
          final surahA = int.parse(partsA[0]);
          final surahB = int.parse(partsB[0]);
          final surahComp = surahA.compareTo(surahB);
          if (surahComp != 0) return surahComp;
          final ayahA = int.parse(partsA[1]);
          final ayahB = int.parse(partsB[1]);
          return ayahA.compareTo(ayahB);
        }
      } catch (_) {}
      final surahComp = a.surah.compareTo(b.surah);
      if (surahComp != 0) return surahComp;
      return a.ayah.compareTo(b.ayah);
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    print("QuranPageView initState - currentAyat: ${widget.currentAyat}");
    _scrollController = ScrollController();
    _initAudioPlayer();
    QuranPageView.targetAyahNotifier.addListener(_onTargetAyahChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndScrollToTarget();
    });
  }

  void _initAudioPlayer() {
    _audioPlayer = ap.AudioPlayer();

    _durSub = _audioPlayer.onDurationChanged.listen((d) {
      if (mounted) {
        setState(() {
          _duration = d;
        });
      }
    });

    _posSub = _audioPlayer.onPositionChanged.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });

    _stateSub = _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == ap.PlayerState.playing;
        });
      }
    });

    // Listen to completion event for autoplay logic
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        _handleAudioCompleted();
      }
    });
  }

  @override
  void didUpdateWidget(QuranPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(
        "QuranPageView didUpdateWidget - old currentAyat: ${oldWidget.currentAyat}, new currentAyat: ${widget.currentAyat}");

    final bool isDifferentList =
        widget.ayahsList.length != oldWidget.ayahsList.length ||
            (widget.ayahsList.isNotEmpty &&
                oldWidget.ayahsList.isNotEmpty &&
                widget.ayahsList.first.id != oldWidget.ayahsList.first.id);

    if (isDifferentList || widget.currentAyat != oldWidget.currentAyat) {
      if (isDifferentList) {
        _stopAudio();
        _ayahKeys.clear();
        _activeHighlightIndex = null;
        _currentPlayingIndex = null;
      }
      _hasScrolledToCurrentAyat = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkAndScrollToTarget();
      });
    }
  }

  @override
  void dispose() {
    _durSub?.cancel();
    _posSub?.cancel();
    _stateSub?.cancel();
    _audioPlayer.dispose();
    QuranPageView.targetAyahNotifier.removeListener(_onTargetAyahChanged);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _playAyah(int index) async {
    final sortedList = _sortedAyahs;
    if (index < 0 || index >= sortedList.length) return;

    final ayah = sortedList[index];
    final audioUrl = ayah.audio.trim();
    if (audioUrl.isEmpty || audioUrl.contains('EmptyString')) return;

    setState(() {
      _currentPlayingIndex = index;
      _activeHighlightIndex = index; // Highlight playing ayah
      _isPlayerVisible = true;
    });

    _scrollToAyah(index);

    ap.Source source;
    if (audioUrl.startsWith('http://') || audioUrl.startsWith('https://')) {
      source = ap.UrlSource(audioUrl);
    } else {
      String assetPath = audioUrl;
      if (assetPath.startsWith('assets/')) {
        assetPath = assetPath.substring('assets/'.length);
      }
      if (!assetPath.startsWith('audios/')) {
        assetPath = 'audios/$assetPath';
      }
      if (!assetPath.endsWith('.mp3')) {
        assetPath = '$assetPath.mp3';
      }
      source = ap.AssetSource(assetPath);
    }

    try {
      await _audioPlayer.stop();
      await _audioPlayer.setPlaybackRate(_playbackSpeed);
      await _audioPlayer.play(source);
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  Future<void> _pauseAudio() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      debugPrint('Error pausing audio: $e');
    }
  }

  Future<void> _resumeAudio() async {
    if (_currentPlayingIndex != null) {
      try {
        await _audioPlayer.resume();
      } catch (e) {
        debugPrint('Error resuming audio: $e');
      }
    } else {
      _playAyah(0);
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
    setState(() {
      _isPlaying = false;
      _isPlayerVisible = false;
      _currentPlayingIndex = null;
      _activeHighlightIndex = null;
    });
  }

  void _handleAudioCompleted() {
    final sortedList = _sortedAyahs;
    if (_isAutoplayActive) {
      final nextIndex = (_currentPlayingIndex ?? 0) + 1;
      if (nextIndex < sortedList.length) {
        _playAyah(nextIndex);
      } else {
        _stopAudio();
      }
    } else {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _playNext() {
    final sortedList = _sortedAyahs;
    final nextIndex = (_currentPlayingIndex ?? 0) + 1;
    if (nextIndex < sortedList.length) {
      _playAyah(nextIndex);
    }
  }

  void _playPrevious() {
    final prevIndex = (_currentPlayingIndex ?? 0) - 1;
    if (prevIndex >= 0) {
      _playAyah(prevIndex);
    }
  }

  void _alignCardTop(GlobalKey key) {
    if (!mounted) return;
    final context = key.currentContext;
    if (context == null) return;
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null && _scrollController.hasClients) {
      final position = box.localToGlobal(Offset.zero);
      final ScrollableState? scrollable = Scrollable.of(context);
      final RenderBox? scrollBox =
          scrollable?.context.findRenderObject() as RenderBox?;
      if (scrollBox != null) {
        final scrollPosition = scrollBox.localToGlobal(Offset.zero);
        final cardTopInViewport = position.dy - scrollPosition.dy;
        final viewportHeight = scrollBox.size.height;
        final targetTop = viewportHeight * 0.15;

        final currentOffset = _scrollController.offset;
        final maxScroll = _scrollController.position.maxScrollExtent;
        final targetOffset = (currentOffset + cardTopInViewport - targetTop)
            .clamp(0.0, maxScroll);

        print(
            "DEBUG: Aligning card top. CardTopInViewport: $cardTopInViewport, TargetTop: $targetTop, CurrentOffset: $currentOffset, TargetOffset: $targetOffset");

        _scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _scrollToAyah(int index) {
    if (!mounted) return;

    // Increment session ID to cancel any active scroll loops
    _scrollSessionId++;
    final currentSession = _scrollSessionId;

    print(
        "DEBUG: _scrollToAyah called for index: $index, session: $currentSession");

    bool hasJumpedToNeighborhood = false;

    void performScroll() {
      if (!mounted || currentSession != _scrollSessionId) {
        print(
            "DEBUG: Scroll session $currentSession cancelled because new session $_scrollSessionId is active.");
        return;
      }

      final key = _ayahKeys[index];
      if (key != null && key.currentContext != null) {
        print(
            "DEBUG: Target key found for index: $index. Aligning card top...");
        _alignCardTop(key);
      } else {
        if (_scrollController.hasClients) {
          final currentOffset = _scrollController.offset;
          final maxScroll = _scrollController.position.maxScrollExtent;
          final isInitialJump = !hasJumpedToNeighborhood;

          double jumpOffset;
          if (isInitialJump) {
            jumpOffset = (index * 220.0).clamp(0.0, maxScroll);
            hasJumpedToNeighborhood = true;
            print("DEBUG: Initial neighborhood jump to: $jumpOffset");
          } else {
            int firstVisible = 0;
            int? minIndex;
            for (var entry in _ayahKeys.entries) {
              if (entry.value.currentContext != null) {
                if (minIndex == null || entry.key < minIndex) {
                  minIndex = entry.key;
                }
              }
            }
            if (minIndex != null) {
              firstVisible = minIndex;
            }

            final isScrollingUp = index < firstVisible;
            jumpOffset = isScrollingUp
                ? (currentOffset - 600.0).clamp(0.0, maxScroll)
                : (currentOffset + 600.0).clamp(0.0, maxScroll);

            print(
                "DEBUG: Fine scroll. VisibleIndex: $firstVisible, targetIndex: $index, directionUp: $isScrollingUp, current: $currentOffset, next: $jumpOffset");
          }

          _scrollController.jumpTo(jumpOffset);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted || currentSession != _scrollSessionId) return;
            final newOffset = _scrollController.offset;
            final keyRetry = _ayahKeys[index];

            final madeProgress =
                (newOffset - currentOffset).abs() > 1.0 || isInitialJump;

            print(
                "DEBUG: Post-jump offset: $newOffset, keyRetry found: ${keyRetry != null}, context found: ${keyRetry?.currentContext != null}, madeProgress: $madeProgress");

            if (keyRetry?.currentContext == null && madeProgress) {
              performScroll();
            } else if (keyRetry?.currentContext != null) {
              print("DEBUG: Key found post-jump! Aligning card top...");
              _alignCardTop(keyRetry!);
            }
          });
        }
      }
    }

    // Scroll immediately post-frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      performScroll();
    });

    // Retry after 350ms to handle page transitions
    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) return;

      // We only run the retry if the target key is still not found/visible
      final key = _ayahKeys[index];
      if (key?.currentContext == null) {
        // Start a new session for the retry to cleanly abort the first one
        _scrollSessionId++;
        final retrySession = _scrollSessionId;
        print(
            "DEBUG: Retry triggered for index: $index, starting new session: $retrySession");

        bool retryHasJumped = false;
        void performRetryScroll() {
          if (!mounted || retrySession != _scrollSessionId) return;
          final k = _ayahKeys[index];
          if (k != null && k.currentContext != null) {
            _alignCardTop(k);
          } else {
            if (_scrollController.hasClients) {
              final currentOffset = _scrollController.offset;
              final maxScroll = _scrollController.position.maxScrollExtent;
              final isInitial = !retryHasJumped;

              double jumpOffset;
              if (isInitial) {
                jumpOffset = (index * 220.0).clamp(0.0, maxScroll);
                retryHasJumped = true;
              } else {
                int firstVisible = 0;
                int? minIndex;
                for (var entry in _ayahKeys.entries) {
                  if (entry.value.currentContext != null) {
                    if (minIndex == null || entry.key < minIndex) {
                      minIndex = entry.key;
                    }
                  }
                }
                if (minIndex != null) {
                  firstVisible = minIndex;
                }

                final isScrollingUp = index < firstVisible;
                jumpOffset = isScrollingUp
                    ? (currentOffset - 600.0).clamp(0.0, maxScroll)
                    : (currentOffset + 600.0).clamp(0.0, maxScroll);
              }

              _scrollController.jumpTo(jumpOffset);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted || retrySession != _scrollSessionId) return;
                final newOffset = _scrollController.offset;
                final keyRetry = _ayahKeys[index];
                final madeProgress =
                    (newOffset - currentOffset).abs() > 1.0 || isInitial;

                if (keyRetry?.currentContext == null && madeProgress) {
                  performRetryScroll();
                } else if (keyRetry?.currentContext != null) {
                  _alignCardTop(keyRetry!);
                }
              });
            }
          }
        }

        performRetryScroll();
      } else {
        print("DEBUG: Retry skipped because target is already visible.");
      }
    });
  }

  void _onTargetAyahChanged() {
    if (!mounted) return;
    if (!_scrollController.hasClients) return;
    final targetId = QuranPageView.targetAyahNotifier.value;
    if (targetId == null) return;

    final index = _sortedAyahs.indexWhere((e) => e.id == targetId);
    if (index != -1) {
      setState(() {
        _activeHighlightIndex = index;
      });
      _scrollToAyah(index);
      QuranPageView.targetAyahNotifier.value = null;
    }
  }

  bool _isTargetPage() {
    if (widget.ayahsList.isEmpty) return false;
    try {
      final state = GoRouterState.of(context);
      final idParam = int.tryParse(state.uri.queryParameters['id'] ?? '');
      final typeParam = state.uri.queryParameters['type'];

      if (idParam == null) return false;

      final firstAyah = widget.ayahsList.first;
      final isSuraType =
          typeParam != null && typeParam.toLowerCase().contains('sur');

      if (isSuraType) {
        return firstAyah.surah == idParam;
      } else {
        return firstAyah.juz == idParam;
      }
    } catch (_) {
      return true;
    }
  }

  void _checkAndScrollToTarget() {
    if (!_scrollController.hasClients) {
      return;
    }
    final targetId = QuranPageView.targetAyahNotifier.value;
    if (targetId != null) {
      final index = _sortedAyahs.indexWhere((e) => e.id == targetId);
      if (index != -1) {
        setState(() {
          _activeHighlightIndex = index;
        });
        _scrollToAyah(index);
        QuranPageView.targetAyahNotifier.value = null;
        _hasScrolledToCurrentAyat = true;
      }
    } else if (widget.currentAyat != null &&
        !_hasScrolledToCurrentAyat &&
        _isTargetPage()) {
      final index =
          _sortedAyahs.indexWhere((e) => e.ayah == widget.currentAyat);
      if (index != -1) {
        setState(() {
          _activeHighlightIndex = index;
        });
        _scrollToAyah(index);
        _hasScrolledToCurrentAyat = true;
      }
    }
  }

  void _toggleFavorite(AyahsStruct ayah) {
    final int globalIndex =
        FFAppState().ayahsList.indexWhere((e) => e.id == ayah.id);
    if (globalIndex != -1) {
      FFAppState().update(() {
        FFAppState().updateAyahsListAtIndex(
          globalIndex,
          (e) => e..fav = !e.fav,
        );
      });
      setState(() {});
    }
  }

  void _shareAyah(AyahsStruct ayah) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final shareText = functions.combineTextFormat(
      ayah.arabic,
      ayah.english,
      ayah.swedish,
    );
    if (box != null) {
      Share.share(
        shareText,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      Share.share(shareText);
    }
  }

  Future<void> _copyAyah(AyahsStruct ayah) async {
    await Clipboard.setData(
      ClipboardData(
        text: functions.combineTextFormat(
          ayah.arabic,
          ayah.english,
          ayah.swedish,
        ),
      ),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ayah kopierad till urklipp'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _changePlaybackSpeed() {
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Uppspelningshastighet'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: speeds.map((speed) {
              return ListTile(
                title: Text('${speed}x'),
                selected: speed == _playbackSpeed,
                onTap: () {
                  setState(() {
                    _playbackSpeed = speed;
                  });
                  _audioPlayer.setPlaybackRate(speed);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  bool _isNewPagePushed() {
    final myRoute = ModalRoute.of(context);
    Route? topRoute;
    Navigator.popUntil(context, (route) {
      topRoute = route;
      return true;
    });
    return topRoute != null && topRoute != myRoute && topRoute is PageRoute;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndScrollToTarget();
    });

    // Listen reactively to FFAppState so setting changes (font sizes, visibility) rebuild this widget instantly
    context.watch<FFAppState>();

    if (_isNewPagePushed()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _stopAudio();
      });
    }

    final settings = FFAppState().qurantSetting;
    final arFont = settings.arFont;
    final swFont = settings.swFont;
    final enFont = settings.enFont;
    final arActive = settings.arActive;
    final swActive = settings.swActive;
    final enActive = settings.enActive;

    final sortedList = _sortedAyahs;

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                top: 24.0,
                bottom: _isPlayerVisible
                    ? (MediaQuery.of(context).padding.bottom + 160.0)
                    : 16.0,
              ),
              itemCount: sortedList.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12.0),
              itemBuilder: (context, index) {
                final ayah = sortedList[index];
                final isHighlighted = _activeHighlightIndex == index;
                final globalKey = _getKey(index);

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Ayah Card
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_activeHighlightIndex == index) {
                            _activeHighlightIndex = null;
                            _stopAudio(); // Hide player and stop audio when clicking again
                          } else {
                            _activeHighlightIndex = index;
                          }
                        });
                      },
                      child: Container(
                        key: globalKey,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                          16.0,
                          isHighlighted ? 48.0 : 24.0,
                          16.0,
                          16.0,
                        ),
                        decoration: BoxDecoration(
                          color: isHighlighted
                              ? FlutterFlowTheme.of(context).quranBg
                              : FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: isHighlighted
                                ? const Color(0xFF2E7D32)
                                : FlutterFlowTheme.of(context).alternate,
                            width:
                                2.0, // Fixed border width prevents content width resizing and dynamic text wrapping shifts
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header: Ayah Identifier & Arabic text
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Ayah key indicator (e.g. 1:1)
                                Text(
                                  '${ayah.surah}:${ayah.ayah}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily:
                                            GoogleFonts.manrope().fontFamily,
                                        fontWeight: FontWeight.bold,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                                const SizedBox(width: 16.0),
                                // Arabic text
                                Expanded(
                                  child: Visibility(
                                    visible: arActive,
                                    child: Text(
                                      ayah.arabic,
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.scheherazadeNew(
                                        fontSize: arFont,
                                        height: 2.0,
                                        fontWeight: FontWeight.bold,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // English translation
                            if (enActive && ayah.english.trim().isNotEmpty) ...[
                              const SizedBox(height: 12.0),
                              Text(
                                ayah.english,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily:
                                          GoogleFonts.manrope().fontFamily,
                                      fontSize: enFont,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                              ),
                            ],
                            // Swedish translation
                            if (swActive && ayah.swedish.trim().isNotEmpty) ...[
                              const SizedBox(height: 12.0),
                              Text(
                                ayah.swedish,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily:
                                          GoogleFonts.manrope().fontFamily,
                                      fontSize: swFont,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // Floating green toolbar at top-center when active
                    if (isHighlighted)
                      Positioned(
                        top: 6,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            height: 36.0,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E7D32),
                              borderRadius: BorderRadius.circular(18.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Bookmark / Fav
                                GestureDetector(
                                  onTap: () => _toggleFavorite(ayah),
                                  child: Icon(
                                    ayah.fav
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                // Share
                                GestureDetector(
                                  onTap: () => _shareAyah(ayah),
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                // Copy
                                GestureDetector(
                                  onTap: () => _copyAyah(ayah),
                                  child: const Icon(
                                    Icons.content_copy,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                // Play
                                GestureDetector(
                                  onTap: () => _playAyah(index),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          if (_isPlayerVisible)
            Positioned(
              left: 12.0,
              right: 12.0,
              bottom: MediaQuery.of(context).padding.bottom + 16.0,
              child: Material(
                color: Colors.transparent,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: FlutterFlowTheme.of(context).quranBg,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Audio Progress Indicator
                        if (_duration.inSeconds > 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  formatDuration(_position),
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                Expanded(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: const Color(0xFF2E7D32),
                                      inactiveTrackColor: Colors.grey.shade300,
                                      thumbColor: const Color(0xFF2E7D32),
                                      trackHeight: 3.0,
                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6.0,
                                      ),
                                    ),
                                    child: Slider(
                                      value:
                                          _position.inSeconds.toDouble().clamp(
                                                0.0,
                                                _duration.inSeconds.toDouble(),
                                              ),
                                      min: 0.0,
                                      max: _duration.inSeconds.toDouble(),
                                      onChanged: (value) {
                                        _audioPlayer.seek(
                                          Duration(seconds: value.toInt()),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  formatDuration(_duration),
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Controls Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Stop
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(36, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                Icons.stop,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              onPressed: _stopAudio,
                            ),
                            // Skip Previous
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(36, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                Icons.fast_rewind,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 26.0,
                              ),
                              onPressed: (_currentPlayingIndex ?? 0) > 0
                                  ? _playPrevious
                                  : null,
                            ),
                            // Play / Pause
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF2E7D32),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(40, 40),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                icon: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 28.0,
                                ),
                                onPressed: () {
                                  if (_isPlaying) {
                                    _pauseAudio();
                                  } else {
                                    _resumeAudio();
                                  }
                                },
                              ),
                            ),
                            // Skip Next
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(36, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                Icons.fast_forward,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 26.0,
                              ),
                              onPressed: (_currentPlayingIndex ?? 0) <
                                      sortedList.length - 1
                                  ? _playNext
                                  : null,
                            ),
                            // Autoplay Toggle
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(36, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                Icons.repeat,
                                color: _isAutoplayActive
                                    ? const Color(0xFF2E7D32)
                                    : FlutterFlowTheme.of(context)
                                        .secondaryText,
                                size: 24.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isAutoplayActive = !_isAutoplayActive;
                                });
                              },
                            ),
                            // Speed
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(36, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                Icons.av_timer,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              onPressed: _changePlaybackSpeed,
                            ),
                            // Close button
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(36, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                Icons.close,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              onPressed: () {
                                _stopAudio();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
