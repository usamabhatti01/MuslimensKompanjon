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
import 'package:audioplayers/audioplayers.dart' as ap;

class SimpleAudioPlayer extends StatefulWidget {
  const SimpleAudioPlayer({
    super.key,
    this.width,
    this.height,
    required this.audioUrl,
  });

  final double? width;

  final double? height;

  final String audioUrl;

  @override
  State<SimpleAudioPlayer> createState() => _SimpleAudioPlayerState();
}

class _SimpleAudioPlayerState extends State<SimpleAudioPlayer> {
  late final ap.AudioPlayer _player;
  bool _isInitialized = false;

  Duration _duration = Duration.zero;

  Duration _position = Duration.zero;

  bool _isMuted = false;

  StreamSubscription<Duration>? _durSub;

  StreamSubscription<Duration>? _posSub;

  StreamSubscription<ap.PlayerState>? _stateSub;

  VoidCallback? _appStateListener;

  @override
  void initState() {
    super.initState();

    _player = ap.AudioPlayer();

    _init();

    _syncWithAppState();
  }

  Future<void> _init() async {
    try {
      final String url = widget.audioUrl;
      ap.Source source;
      if (url.startsWith('http://') || url.startsWith('https://')) {
        source = ap.UrlSource(url);
      } else {
        String assetPath = url;
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

      await _player.setSource(source);
      _isInitialized = true;

      _durSub = _player.onDurationChanged.listen((duration) {
        if (!mounted) return;

        setState(() {
          _duration = duration;
        });
      });

      _posSub = _player.onPositionChanged.listen((position) {
        if (!mounted) return;

        setState(() {
          _position = position;
        });
      });

      _stateSub = _player.onPlayerStateChanged.listen((state) {
        if (!mounted) return;

        setState(() {});
      });

      _applyAppMuteState();
    } catch (e) {
      debugPrint('Audio init error: $e');
    }
  }

  void _syncWithAppState() {
    _applyAppMuteState();

    _appStateListener = () {
      if (!mounted) return;

      _applyAppMuteState();
    };

    FFAppState().addListener(_appStateListener!);
  }

  void _applyAppMuteState() {
    final shouldMute = !FFAppState().adhkarSound;

    _setMute(shouldMute);
  }

  Future<void> _setMute(bool mute) async {
    _isMuted = mute;

    if (_isInitialized) {
      try {
        await _player.setVolume(mute ? 0.0 : 1.0);
      } catch (e) {
        debugPrint('Error setting volume: $e');
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _toggleMute() {
    _setMute(!_isMuted);
  }

  Future<void> _togglePlay() async {
    if (!_isInitialized) return;
    try {
      if (_player.state == ap.PlayerState.playing) {
        await _player.pause();
      } else {
        await _player.resume();
      }
    } catch (e) {
      debugPrint('Error toggle play: $e');
    }
  }

  void _seekRelative(int seconds) {
    if (!_isInitialized) return;
    Duration newPos = _position + Duration(seconds: seconds);

    if (newPos < Duration.zero) {
      newPos = Duration.zero;
    }

    if (newPos > _duration) {
      newPos = _duration;
    }

    _player.seek(newPos);
  }

  void _seekTo(double value) {
    if (!_isInitialized) return;
    _player.seek(Duration(seconds: value.toInt()));
  }

  @override
  void dispose() {
    _posSub?.cancel();

    _durSub?.cancel();

    _stateSub?.cancel();

    if (_appStateListener != null) {
      FFAppState().removeListener(_appStateListener!);
    }

    _player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxSeconds =
        _duration.inSeconds > 0 ? _duration.inSeconds.toDouble() : 1.0;

    final currentSeconds =
        _position.inSeconds.toDouble().clamp(0.0, maxSeconds);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          min: 0,
          max: maxSeconds,
          value: currentSeconds,
          onChanged: _seekTo,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.replay_10),
              onPressed: () => _seekRelative(-10),
            ),
            IconButton(
              iconSize: 40,
              icon: Icon(
                (_isInitialized && _player.state == ap.PlayerState.playing)
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: _togglePlay,
            ),
            IconButton(
              icon: const Icon(Icons.forward_10),
              onPressed: () => _seekRelative(10),
            ),
          ],
        ),
      ],
    );
  }
}
