// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import '/app_state.dart';

class AdhkarTrackTag {
  final int adhkarIndex;
  final int repetitionIndex;
  final int totalRepetitions;
  final String audioUrl;

  const AdhkarTrackTag({
    required this.adhkarIndex,
    required this.repetitionIndex,
    required this.totalRepetitions,
    required this.audioUrl,
  });
}

class AdhkarPageView extends StatefulWidget {
  const AdhkarPageView({
    super.key,
    this.width,
    this.height,
    required this.adhkarList,
  });

  final double? width;
  final double? height;
  final List<AdhkarStruct> adhkarList;

  @override
  State<AdhkarPageView> createState() => _AdhkarPageViewState();
}

class _AdhkarPageViewState extends State<AdhkarPageView>
    with RouteAware, WidgetsBindingObserver {
  // Counters state for each item in list
  final Map<int, int> _itemCounters = {};

  // Audio Player state
  late AudioPlayer _audioPlayer;
  final List<AdhkarTrackTag> _trackTags = [];
  final Map<int, int> _adhkarToSequenceIndex = {};
  Future<void>? _playlistFuture;

  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  Future<void> _triggerHaptic() async {
    if (FFAppState().haptic) {
      try {
        HapticFeedback.lightImpact();
      } catch (_) {}
      try {
        final hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator == true) {
          Vibration.vibrate(duration: 40);
        }
      } catch (_) {}
    }
  }

  double _playbackSpeed = 1.0;

  // Stream Subscriptions
  StreamSubscription<Duration?>? _durSub;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<int?>? _seqSub;

  // Active playing & scrolling states
  int? _currentPlayingIndex;
  int? _selectedIndex;
  int? _targetAdhkarIndex;
  bool? _prevAudioCheck;

  // Keys and ScrollController for auto-scrolling
  final Map<int, GlobalKey> _itemKeys = {};
  late ScrollController _scrollController;

  GlobalKey _getKey(int index) {
    return _itemKeys.putIfAbsent(index, () => GlobalKey());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    _prevAudioCheck = FFAppState().adhkarSetting.audioDisplay;
    _playlistFuture = _initAudioPlayer();
    _preloadAudios();
  }

  @override
  void didUpdateWidget(AdhkarPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.adhkarList != oldWidget.adhkarList) {
      _playlistFuture = _buildAndSetPlaylist();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  void _clearSelection() {
    _stopAudio();
    _selectedIndex = null;
    _currentPlayingIndex = null;

    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void didPushNext() {
    _clearSelection();
    super.didPushNext();
  }

  @override
  void didPop() {
    _clearSelection();
    super.didPop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _stopAudio();
    }
  }

  Future<void> _initAudioPlayer() async {
    _audioPlayer = AudioPlayer();

    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
    } catch (e) {
      debugPrint('Error configuring AudioSession: $e');
    }

    _durSub = _audioPlayer.durationStream.listen((d) {
      if (mounted && d != null) {
        setState(() {
          _duration = d;
        });
      }
    });

    _posSub = _audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });

    _stateSub = _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
      if (state.processingState == ProcessingState.completed) {
        _stopAudio();
      }
    });

    _seqSub = _audioPlayer.currentIndexStream.listen((seqIndex) {
      if (_selectedIndex == null ||
          (!_isPlaying && !_audioPlayer.playerState.playing)) {
        return;
      }
      if (seqIndex != null && seqIndex < _trackTags.length) {
        final tag = _trackTags[seqIndex];
        final adhkarIndex = tag.adhkarIndex;

        // If the user tapped a specific item, ignore any leftover events from the old track
        if (_targetAdhkarIndex != null) {
          if (adhkarIndex != _targetAdhkarIndex) {
            return;
          }
          _targetAdhkarIndex = null;
        }

        final remainingCount = tag.totalRepetitions - (tag.repetitionIndex + 1);

        if (mounted) {
          final isNew = _currentPlayingIndex != adhkarIndex;
          setState(() {
            _currentPlayingIndex = adhkarIndex;
            _selectedIndex = adhkarIndex;
            _itemCounters[adhkarIndex] =
                remainingCount.clamp(0, tag.totalRepetitions);
          });
          if (isNew) {
            _scrollToItem(adhkarIndex);
          }
        }
      }
    });

    await _buildAndSetPlaylist();
  }

  Future<void> _buildAndSetPlaylist() async {
    final List<AudioSource> sources = [];
    _trackTags.clear();
    _adhkarToSequenceIndex.clear();

    String? audioDirPath;
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final audioDir = Directory('${docsDir.path}/adhkar_audio');
      if (await audioDir.exists()) {
        audioDirPath = audioDir.path;
      }
    } catch (_) {}

    for (int i = 0; i < widget.adhkarList.length; i++) {
      final item = widget.adhkarList[i];
      if (!_hasValidAudio(item)) continue;

      final audioUrl = item.audio.trim();
      final targetCount = item.counter > 0 ? item.counter : 1;
      _adhkarToSequenceIndex[i] = sources.length;

      AudioSource createSource(AdhkarTrackTag tag) {
        if (audioUrl.startsWith('http://') || audioUrl.startsWith('https://')) {
          final fileName = audioUrl.split('/').last;
          if (audioDirPath != null) {
            final localFile = File('$audioDirPath/$fileName');
            if (localFile.existsSync() && localFile.lengthSync() > 0) {
              return AudioSource.uri(Uri.file(localFile.path), tag: tag);
            }
          }
          return AudioSource.uri(Uri.parse(audioUrl), tag: tag);
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
          return AudioSource.asset(assetPath, tag: tag);
        }
      }

      for (int rep = 0; rep < targetCount; rep++) {
        final tag = AdhkarTrackTag(
          adhkarIndex: i,
          repetitionIndex: rep,
          totalRepetitions: targetCount,
          audioUrl: audioUrl,
        );
        _trackTags.add(tag);
        sources.add(createSource(tag));
      }
    }

    if (sources.isNotEmpty) {
      try {
        await _audioPlayer.setAudioSources(
          sources,
          preload: false,
          initialIndex: 0,
          initialPosition: Duration.zero,
        );
      } catch (e) {
        debugPrint('Error setting AudioSources playlist: $e');
      }
    }
  }

  void _preloadAudios() {
    Future.microtask(() async {
      final List<AdhkarStruct> validItems =
          widget.adhkarList.where(_hasValidAudio).toList();
      const int batchSize = 4;
      for (int i = 0; i < validItems.length; i += batchSize) {
        if (!mounted) break;
        final end = (i + batchSize < validItems.length)
            ? i + batchSize
            : validItems.length;
        final batch = validItems.sublist(i, end);
        await Future.wait(batch.map((item) => _cacheAudio(item.audio.trim())));
      }
    });
  }

  Future<void> _cacheAudio(String audioUrl) async {
    final trimmedUrl = audioUrl.trim();
    if (!trimmedUrl.startsWith('http://') &&
        !trimmedUrl.startsWith('https://')) {
      return;
    }
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final audioDir = Directory('${docsDir.path}/adhkar_audio');
      if (!await audioDir.exists()) {
        await audioDir.create(recursive: true);
      }
      final fileName = trimmedUrl.split('/').last;
      final localFile = File('${audioDir.path}/$fileName');
      if (await localFile.exists() && (await localFile.length()) > 0) {
        return;
      }
      final response = await http
          .get(Uri.parse(trimmedUrl))
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        final tmpFile = File('${audioDir.path}/$fileName.tmp');
        await tmpFile.writeAsBytes(response.bodyBytes);
        await tmpFile.rename(localFile.path);
        debugPrint('Pre-cached audio locally: ${localFile.path}');
      }
    } catch (e) {
      debugPrint('Error pre-caching audio: $e');
    }
  }

  @override
  void deactivate() {
    _clearSelection();
    _stopAudio();
    try {
      _audioPlayer.stop();
    } catch (_) {}
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    _durSub?.cancel();
    _posSub?.cancel();
    _stateSub?.cancel();
    _seqSub?.cancel();
    try {
      _audioPlayer.stop();
    } catch (_) {}
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool _hasValidAudio(AdhkarStruct item) {
    final a = item.audio.trim();
    return a.isNotEmpty && a != 'nill' && !a.contains('EmptyString');
  }

  Widget _buildArabicRichText({
    required String text,
    required double fontSize,
    required Color textColor,
    double height = 2.0,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign textAlign = TextAlign.right,
  }) {
    final trimmed = text.trim();
    final ayahRegex = RegExp(r'۝([0-9\u0660-\u0669]+)');
    final matches = ayahRegex.allMatches(trimmed);

    if (matches.isEmpty) {
      return Text(
        trimmed,
        textAlign: textAlign,
        textDirection: ui.TextDirection.rtl,
        style: GoogleFonts.scheherazadeNew(
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          color: textColor,
        ),
      );
    }

    final List<InlineSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: trimmed.substring(lastEnd, match.start),
            style: GoogleFonts.scheherazadeNew(
              fontSize: fontSize,
              fontWeight: fontWeight,
              height: height,
              color: textColor,
            ),
          ),
        );
      }

      final digits = match.group(1)!;
      final digitFontSize = digits.length >= 3
          ? fontSize * 0.28
          : (digits.length == 2 ? fontSize * 0.34 : fontSize * 0.40);

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            width: fontSize * 1.15,
            height: fontSize * 1.15,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '۝',
                  textDirection: ui.TextDirection.rtl,
                  style: GoogleFonts.scheherazadeNew(
                    fontSize: fontSize * 1.05,
                    height: 1.0,
                    color: textColor,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: Text(
                      digits,
                      textDirection: ui.TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.scheherazadeNew(
                        fontSize: digitFontSize,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < trimmed.length) {
      spans.add(
        TextSpan(
          text: trimmed.substring(lastEnd),
          style: GoogleFonts.scheherazadeNew(
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
            color: textColor,
          ),
        ),
      );
    }

    return Text.rich(
      TextSpan(children: spans),
      textAlign: textAlign,
      textDirection: ui.TextDirection.rtl,
    );
  }

  Future<void> _playAdhkar(int index) async {
    if (index < 0 || index >= widget.adhkarList.length) return;

    if (!FFAppState().adhkarSetting.audioDisplay) {
      _targetAdhkarIndex = null;
      _stopAudio();
      setState(() {
        _currentPlayingIndex = index;
        _selectedIndex = index;
      });
      _scrollToItem(index);
      return;
    }

    final item = widget.adhkarList[index];
    final hasAudio = _hasValidAudio(item);

    _targetAdhkarIndex = index;
    setState(() {
      _selectedIndex = index;
      _currentPlayingIndex = index;
    });
    _scrollToItem(index);

    if (!hasAudio) {
      _targetAdhkarIndex = null;
      _stopAudio();
      return;
    }

    if (_playlistFuture != null) {
      await _playlistFuture;
    }

    final seqIndex = _adhkarToSequenceIndex[index];
    if (seqIndex != null && seqIndex < _trackTags.length) {
      try {
        await _audioPlayer.setSpeed(_playbackSpeed);
        await _audioPlayer.seek(Duration.zero, index: seqIndex);
        await _audioPlayer.play();
      } catch (e) {
        debugPrint('Error playing Adhkar audio at seqIndex $seqIndex: $e');
      }
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
    if (!FFAppState().adhkarSetting.audioDisplay) {
      _stopAudio();
      return;
    }

    if (_playlistFuture != null) {
      await _playlistFuture;
    }

    if (_audioPlayer.currentIndex != null) {
      try {
        await _audioPlayer.setSpeed(_playbackSpeed);
        await _audioPlayer.play();
      } catch (e) {
        debugPrint('Error resuming audio: $e');
      }
    } else {
      final startIndex = _selectedIndex ?? 0;
      _playAdhkar(startIndex);
    }
  }

  Future<void> _stopAudio() async {
    _targetAdhkarIndex = null;
    _isPlaying = false;
    try {
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
    if (mounted) {
      setState(() {
        _isPlaying = false;
        _currentPlayingIndex = null;
        _position = Duration.zero;
      });
    }
  }

  bool _canPlayPrevious() {
    final current = _currentPlayingIndex ?? _selectedIndex;
    if (current == null) return false;
    for (int prev = current - 1; prev >= 0; prev--) {
      if (_adhkarToSequenceIndex.containsKey(prev)) {
        return true;
      }
    }
    return false;
  }

  void _playPreviousAdhkar() {
    final current = _currentPlayingIndex ?? _selectedIndex;
    if (current == null) return;
    for (int prev = current - 1; prev >= 0; prev--) {
      if (_adhkarToSequenceIndex.containsKey(prev)) {
        _playAdhkar(prev);
        return;
      }
    }
  }

  bool _canPlayNext() {
    final current = _currentPlayingIndex ?? _selectedIndex ?? -1;
    for (int next = current + 1; next < widget.adhkarList.length; next++) {
      if (_adhkarToSequenceIndex.containsKey(next)) {
        return true;
      }
    }
    return false;
  }

  void _playNextAdhkar() {
    final current = _currentPlayingIndex ?? _selectedIndex ?? -1;
    for (int next = current + 1; next < widget.adhkarList.length; next++) {
      if (_adhkarToSequenceIndex.containsKey(next)) {
        _playAdhkar(next);
        return;
      }
    }
  }

  void _scrollToItem(int index) {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;

      final key = _itemKeys[index];
      final context = key?.currentContext;
      if (context != null) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        final ScrollableState? scrollable = Scrollable.of(context);
        final RenderBox? scrollBox =
            scrollable?.context.findRenderObject() as RenderBox?;
        if (box != null && scrollBox != null) {
          final position = box.localToGlobal(Offset.zero);
          final scrollPosition = scrollBox.localToGlobal(Offset.zero);
          final cardTopInViewport = position.dy - scrollPosition.dy;
          final currentOffset = _scrollController.offset;
          final maxScroll = _scrollController.position.maxScrollExtent;
          final targetOffset =
              (currentOffset + cardTopInViewport).clamp(0.0, maxScroll);

          _scrollController.animateTo(
            targetOffset,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          );
          return;
        }
      }

      // Fallback if not rendered yet
      final maxScroll = _scrollController.position.maxScrollExtent;
      final estimatedOffset = (index * 500.0).clamp(0.0, maxScroll);
      _scrollController
          .animateTo(
        estimatedOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted || !_scrollController.hasClients) return;
          final targetKey = _itemKeys[index];
          final targetContext = targetKey?.currentContext;
          if (targetContext != null) {
            final RenderBox? box =
                targetContext.findRenderObject() as RenderBox?;
            final ScrollableState? scrollable = Scrollable.of(targetContext);
            final RenderBox? scrollBox =
                scrollable?.context.findRenderObject() as RenderBox?;
            if (box != null && scrollBox != null) {
              final position = box.localToGlobal(Offset.zero);
              final scrollPosition = scrollBox.localToGlobal(Offset.zero);
              final cardTopInViewport = position.dy - scrollPosition.dy;
              final currentOffset = _scrollController.offset;
              final maxScroll = _scrollController.position.maxScrollExtent;
              final targetOffset =
                  (currentOffset + cardTopInViewport).clamp(0.0, maxScroll);

              _scrollController.animateTo(
                targetOffset,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        });
      });
    });
  }

  void _cyclePlaybackSpeed() {
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 1.25;
      } else if (_playbackSpeed == 1.25) {
        _playbackSpeed = 1.5;
      } else if (_playbackSpeed == 1.5) {
        _playbackSpeed = 2.0;
      } else {
        _playbackSpeed = 1.0;
      }
    });
    try {
      _audioPlayer.setSpeed(_playbackSpeed);
    } catch (_) {}
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final adhkarSettings = FFAppState().adhkarSetting;
    final isAudioCheckEnabled = adhkarSettings.audioDisplay;
    final list = widget.adhkarList;
    final arFont = adhkarSettings.arFont;
    final swFont = adhkarSettings.swFont;
    final enFont = adhkarSettings.enFont;
    final arActive = adhkarSettings.arActive;
    final swActive = adhkarSettings.swActive;
    final enActive = adhkarSettings.enActive;

    if (_prevAudioCheck != null && _prevAudioCheck != isAudioCheckEnabled) {
      final wasEnabled = _prevAudioCheck!;
      _prevAudioCheck = isAudioCheckEnabled;
      if (wasEnabled && !isAudioCheckEnabled) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _stopAudio();
          }
        });
      } else if (!wasEnabled && isAudioCheckEnabled) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final targetIndex = _selectedIndex ?? 0;
            if (targetIndex >= 0 && targetIndex < widget.adhkarList.length) {
              final item = widget.adhkarList[targetIndex];
              if (_hasValidAudio(item)) {
                _playAdhkar(targetIndex);
              }
            }
          }
        });
      }
    } else {
      _prevAudioCheck = isAudioCheckEnabled;
    }

    if (list.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Center(
          child: Text(
            'Inga adhkar tillgängliga',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
        ),
      );
    }

    final showPlayerOverlay = isAudioCheckEnabled;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        _stopAudio();
      },
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        child: Stack(
          children: [
            // Scrollable Cards List
            Positioned.fill(
              child: ListView.builder(
                controller: _scrollController,
                cacheExtent: 50000.0,
                padding: EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  top: 12.0,
                  bottom: showPlayerOverlay ? 120.0 : 12.0,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  final isPlayingThis = _currentPlayingIndex == index;
                  final targetCount = item.counter > 0 ? item.counter : 1;
                  final currentCount = _itemCounters[index] ?? targetCount;

                  final isSelectedThis = _selectedIndex == index;
                  final isHighlighted = isPlayingThis || isSelectedThis;

                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(16.0),
                    onTap: () {
                      final isAudioCheckEnabled =
                          FFAppState().adhkarSetting.audioDisplay;

                      if (_selectedIndex == index) {
                        _targetAdhkarIndex = null;
                        _stopAudio();
                        setState(() {
                          _selectedIndex = null;
                          _currentPlayingIndex = null;
                        });
                      } else {
                        _targetAdhkarIndex = index;
                        setState(() {
                          _selectedIndex = index;
                          _currentPlayingIndex = index;
                        });
                        if (isAudioCheckEnabled && _hasValidAudio(item)) {
                          _playAdhkar(index);
                        } else {
                          _stopAudio();
                          _scrollToItem(index);
                        }
                      }
                    },
                    child: Container(
                      key: _getKey(index),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: isHighlighted
                            ? FlutterFlowTheme.of(context)
                                .primary
                                .withValues(alpha: 0.05)
                            : FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: isHighlighted
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context)
                                  .alternate
                                  .withValues(alpha: 0.6),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isHighlighted
                                ? FlutterFlowTheme.of(context)
                                    .primary
                                    .withValues(alpha: 0.15)
                                : Colors.black.withValues(alpha: 0.04),
                            blurRadius: isHighlighted ? 10.0 : 6.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Arabic text
                          if (arActive && item.arabic.trim().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 14.0,
                                  bottom: 4.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: _buildArabicRichText(
                                  text: item.arabic,
                                  fontSize: arFont,
                                  textColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),

                          // Transliteration / Translation text (e.g., In the name of Allah...)
                          if (enActive &&
                              item.translitterering.trim().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 8.0,
                                  bottom: 4.0),
                              child: Text(
                                item.translitterering.trim(),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.manrope(
                                  fontSize: enFont,
                                  color: const Color(0xFF727272),
                                  height: 1.5,
                                ),
                              ),
                            ),

                          // Swedish translation text (e.g., I GUDS, DEN NÅDERIKES...)
                          if (swActive && item.swedish.trim().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: Text(
                                item.swedish.trim(),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.manrope(
                                  fontSize: swFont,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  height: 1.5,
                                ),
                              ),
                            ),

                          // Primary Counter Bar (Matching Reference Image)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                bottom: 12.0,
                                top: 6.0),
                            child: Container(
                              height: 48.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8.0),
                                  // Reset Counter Button
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                        minWidth: 36, minHeight: 36),
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                    tooltip: 'Återställ',
                                    onPressed: () {
                                      _triggerHaptic();
                                      setState(() {
                                        _itemCounters[index] = targetCount;
                                      });
                                    },
                                  ),

                                  // Center Area: Main Big Counter Number (Tap to decrement / count down)
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _triggerHaptic();
                                        setState(() {
                                          _selectedIndex = index;
                                          if (currentCount > 0) {
                                            _itemCounters[index] =
                                                currentCount - 1;
                                          } else {
                                            _itemCounters[index] = 0;
                                          }
                                        });
                                      },
                                      child: Center(
                                        child: Text(
                                          '$currentCount',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Right Card Index Number (e.g. 1, 2, 3... 30)
                                  Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Color(0xFFD1D5DB),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Floating Quran-Style Audio Player Card Overlay
            if (showPlayerOverlay)
              Positioned(
                left: 14.0,
                right: 14.0,
                bottom: 18.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFFEBF4EC), // Solid light mint green matching screenshot 2
                    borderRadius: BorderRadius.circular(20.0),
                    border:
                        Border.all(color: const Color(0xFFC8E6C9), width: 1.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 16.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top Row: Time Progress Slider & Timestamps (00:00 ------- 00:06)
                      Row(
                        children: [
                          Text(
                            _formatDuration(_position),
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333),
                            ),
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 3.0,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 6.0),
                                overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 12.0),
                              ),
                              child: Slider(
                                activeColor: const Color(0xFF2B7A3E),
                                inactiveColor:
                                    Colors.black.withValues(alpha: 0.10),
                                value: _duration.inMilliseconds > 0
                                    ? _position.inMilliseconds
                                        .clamp(0, _duration.inMilliseconds)
                                        .toDouble()
                                    : 0.0,
                                max: _duration.inMilliseconds > 0
                                    ? _duration.inMilliseconds.toDouble()
                                    : 1.0,
                                onChanged: (val) {
                                  _audioPlayer.seek(
                                      Duration(milliseconds: val.toInt()));
                                },
                              ),
                            ),
                          ),
                          Text(
                            _formatDuration(_duration),
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6.0),

                      // Bottom Controls Row: Stop, Prev, Big Green Play/Pause, Next, Loop, Speed, Close
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // 1. Stop Button (Square)
                            IconButton(
                              constraints: const BoxConstraints(
                                  minWidth: 34, minHeight: 34),
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.stop,
                                  color: Color(0xFF333333), size: 22.0),
                              tooltip: 'Stoppa',
                              onPressed: () {
                                _stopAudio();
                              },
                            ),

                            // 2. Previous Track
                            IconButton(
                              constraints: const BoxConstraints(
                                  minWidth: 34, minHeight: 34),
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.skip_previous,
                                  color: Color(0xFF333333), size: 24.0),
                              tooltip: 'Föregående',
                              onPressed: _canPlayPrevious()
                                  ? () => _playPreviousAdhkar()
                                  : null,
                            ),

                            // 3. Main Play / Pause Circle Button (Green Circle)
                            InkWell(
                              onTap: () {
                                if (_isPlaying) {
                                  _pauseAudio();
                                } else if (_currentPlayingIndex != null) {
                                  _resumeAudio();
                                } else {
                                  _playAdhkar(_selectedIndex ?? 0);
                                }
                              },
                              child: Container(
                                width: 46.0,
                                height: 46.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2B7A3E),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 28.0,
                                ),
                              ),
                            ),

                            // 4. Next Track
                            IconButton(
                              constraints: const BoxConstraints(
                                  minWidth: 34, minHeight: 34),
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.skip_next,
                                  color: Color(0xFF333333), size: 24.0),
                              tooltip: 'Nästa',
                              onPressed: _canPlayNext()
                                  ? () => _playNextAdhkar()
                                  : null,
                            ),

                            // 5. Speed Cycle Button
                            InkWell(
                              onTap: _cyclePlaybackSpeed,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2B7A3E)
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  '${_playbackSpeed}x',
                                  style: const TextStyle(
                                    color: Color(0xFF2B7A3E),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),

                            // 7. Close Player
                            IconButton(
                              constraints: const BoxConstraints(
                                  minWidth: 34, minHeight: 34),
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.close,
                                  color: Color(0xFF333333), size: 20.0),
                              tooltip: 'Stäng spelare',
                              onPressed: () {
                                _stopAudio();
                                FFAppState().updateAdhkarSettingStruct(
                                    (e) => e..audioDisplay = false);
                                FFAppState().update(() {});
                                setState(() {
                                  _selectedIndex = null;
                                  _currentPlayingIndex = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
