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

import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '/app_state.dart';

class SimpleAudioPlayer extends StatefulWidget {
  const SimpleAudioPlayer({
    super.key,
    this.width,
    this.height,
    this.audioUrl = 'assets/audios/AllahNamesAr.mp3',
    this.autoPlay = false,
  });

  final double? width;
  final double? height;
  final String? audioUrl;
  final bool autoPlay;

  @override
  State<SimpleAudioPlayer> createState() => _SimpleAudioPlayerState();
}

class _SimpleAudioPlayerState extends State<SimpleAudioPlayer>
    with WidgetsBindingObserver, RouteAware {
  late ap.AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _playbackSpeed = 1.0;

  StreamSubscription<Duration>? _durSub;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<ap.PlayerState>? _stateSub;
  int _playSessionId = 0;

  String get _currentAudioUrl {
    final url = widget.audioUrl?.trim() ?? '';
    return url.isNotEmpty ? url : 'assets/audios/AllahNamesAr.mp3';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initAudioPlayer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  @override
  void didPop() {
    _stopAudio();
    FFAppState().updateAdhkarSettingStruct((e) => e..audioDisplay = false);
    super.didPop();
  }

  @override
  void deactivate() {
    _stopAudio();
    super.deactivate();
  }

  void _initAudioPlayer() {
    _audioPlayer = ap.AudioPlayer();
    _audioPlayer.setReleaseMode(ap.ReleaseMode.stop);
    _audioPlayer.setAudioContext(
      const ap.AudioContext(
        iOS: ap.AudioContextIOS(
          category: ap.AVAudioSessionCategory.playback,
          options: [
            ap.AVAudioSessionOptions.defaultToSpeaker,
          ],
        ),
        android: ap.AudioContextAndroid(
          isSpeakerphoneOn: false,
          stayAwake: true,
          contentType: ap.AndroidContentType.music,
          usageType: ap.AndroidUsageType.media,
          audioFocus: ap.AndroidAudioFocus.gain,
        ),
      ),
    );

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

    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _position = Duration.zero;
        });
      }
    });
  }

  Future<ap.Source> _getAudioSource(String audioUrl) async {
    final trimmedUrl = audioUrl.trim();
    if (trimmedUrl.startsWith('http://') || trimmedUrl.startsWith('https://')) {
      try {
        final docsDir = await getApplicationDocumentsDirectory();
        final audioDir = Directory('${docsDir.path}/app_audio');
        if (!await audioDir.exists()) {
          await audioDir.create(recursive: true);
        }

        final fileName = trimmedUrl.split('/').last;
        final localFile = File('${audioDir.path}/$fileName');

        if (await localFile.exists() && (await localFile.length()) > 0) {
          return ap.DeviceFileSource(localFile.path);
        }

        final response = await http
            .get(Uri.parse(trimmedUrl))
            .timeout(const Duration(seconds: 5));
        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          await localFile.writeAsBytes(response.bodyBytes);
          return ap.DeviceFileSource(localFile.path);
        }
      } catch (e) {
        debugPrint('Error loading cached audio: $e');
      }
      return ap.UrlSource(trimmedUrl);
    } else {
      String assetPath = trimmedUrl;
      if (assetPath.contains('assets/audios/')) {
        assetPath = assetPath
            .substring(assetPath.indexOf('assets/audios/') + 'assets/'.length);
      } else if (assetPath.contains('audios/')) {
        assetPath = assetPath.substring(assetPath.indexOf('audios/'));
      } else if (assetPath.startsWith('assets/')) {
        assetPath = assetPath.substring('assets/'.length);
      }
      if (!assetPath.startsWith('audios/')) {
        assetPath = 'audios/$assetPath';
      }
      if (!assetPath.toLowerCase().endsWith('.mp3')) {
        assetPath = '$assetPath.mp3';
      }
      return ap.AssetSource(assetPath);
    }
  }

  Future<void> _playAudio() async {
    final audioToPlay = _currentAudioUrl;
    if (audioToPlay.isEmpty) return;
    final currentSession = ++_playSessionId;

    try {
      final source = await _getAudioSource(audioToPlay);
      if (!mounted || _playSessionId != currentSession) return;

      await _audioPlayer.stop();
      await _audioPlayer.setPlaybackRate(_playbackSpeed);
      await _audioPlayer.setVolume(1.0);
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
    if (_position >= _duration && _duration > Duration.zero) {
      _playAudio();
      return;
    }
    try {
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.resume();
    } catch (e) {
      debugPrint('Error resuming audio: $e');
      _playAudio();
    }
  }

  Future<void> _stopAudio() async {
    _playSessionId++;
    try {
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
    if (mounted) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    }
  }

  void _seekRelative(int seconds) {
    Duration newPos = _position + Duration(seconds: seconds);
    if (newPos < Duration.zero) newPos = Duration.zero;
    if (_duration > Duration.zero && newPos > _duration) newPos = _duration;
    _audioPlayer.seek(newPos);
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
    if (_isPlaying) {
      _audioPlayer.setPlaybackRate(_playbackSpeed);
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _stopAudio();
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    _playSessionId++;
    _durSub?.cancel();
    _posSub?.cancel();
    _stateSub?.cancel();
    try {
      _audioPlayer.stop();
      _audioPlayer.release();
    } catch (_) {}
    _audioPlayer.dispose();
    FFAppState().updateAdhkarSettingStruct((e) => e..audioDisplay = false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<FFAppState>(context);
    final isAudioVisible = appState.adhkarSetting.audioDisplay;

    if (!isAudioVisible) {
      if (_isPlaying) {
        _stopAudio();
      }
      return const SizedBox.shrink();
    }

    return Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color:
            const Color(0xFFEBF4EC), // Solid light mint green matching Adhkar
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFFC8E6C9), width: 1.0),
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
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 12.0),
                  ),
                  child: Slider(
                    activeColor: const Color(0xFF2B7A3E),
                    inactiveColor: Colors.black.withValues(alpha: 0.10),
                    value: _duration.inMilliseconds > 0
                        ? _position.inMilliseconds
                            .clamp(0, _duration.inMilliseconds)
                            .toDouble()
                        : 0.0,
                    max: _duration.inMilliseconds > 0
                        ? _duration.inMilliseconds.toDouble()
                        : 1.0,
                    onChanged: (val) {
                      _audioPlayer.seek(Duration(milliseconds: val.toInt()));
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

          // Bottom Controls Row: Stop, Rewind 10s, Big Green Play/Pause, Fast Forward 10s, Speed, Close
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 1. Stop Button (Square)
                IconButton(
                  constraints:
                      const BoxConstraints(minWidth: 34, minHeight: 34),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.stop,
                      color: Color(0xFF333333), size: 22.0),
                  tooltip: 'Stoppa',
                  onPressed: _stopAudio,
                ),

                // 2. Rewind 10s / Previous
                IconButton(
                  constraints:
                      const BoxConstraints(minWidth: 34, minHeight: 34),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.replay_10,
                      color: Color(0xFF333333), size: 24.0),
                  tooltip: '-10s',
                  onPressed: () => _seekRelative(-10),
                ),

                // 3. Main Play / Pause Circle Button (Green Circle)
                InkWell(
                  onTap: () {
                    if (_isPlaying) {
                      _pauseAudio();
                    } else if (_position > Duration.zero) {
                      _resumeAudio();
                    } else {
                      _playAudio();
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

                // 4. Forward 10s / Next
                IconButton(
                  constraints:
                      const BoxConstraints(minWidth: 34, minHeight: 34),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.forward_10,
                      color: Color(0xFF333333), size: 24.0),
                  tooltip: '+10s',
                  onPressed: () => _seekRelative(10),
                ),

                // 5. Speed Cycle Button
                InkWell(
                  onTap: _cyclePlaybackSpeed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B7A3E).withValues(alpha: 0.12),
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

                // 6. Close Player
                IconButton(
                  constraints:
                      const BoxConstraints(minWidth: 34, minHeight: 34),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.close,
                      color: Color(0xFF333333), size: 20.0),
                  tooltip: 'Stäng spelare',
                  onPressed: () {
                    _stopAudio();
                    FFAppState().updateAdhkarSettingStruct(
                      (e) => e..audioDisplay = false,
                    );
                    FFAppState().update(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
