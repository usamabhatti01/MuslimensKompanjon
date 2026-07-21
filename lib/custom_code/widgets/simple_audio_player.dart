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
    this.autoPlay = false,
  });

  final double? width;

  final double? height;

  final String audioUrl;

  final bool autoPlay;

  @override
  State<SimpleAudioPlayer> createState() => _SimpleAudioPlayerState();
}

class _SimpleAudioPlayerState extends State<SimpleAudioPlayer> {
  static final ap.AudioPlayer _sharedPlayer = ap.AudioPlayer();
  static _SimpleAudioPlayerState? _activePlayerState;

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
    _isInitialized = true;

    _durSub = _sharedPlayer.onDurationChanged.listen((duration) {
      if (!mounted) return;
      if (_activePlayerState == this) {
        setState(() {
          _duration = duration;
        });
      }
    });

    _posSub = _sharedPlayer.onPositionChanged.listen((position) {
      if (!mounted) return;
      if (_activePlayerState == this) {
        setState(() {
          _position = position;
        });
      }
    });

    _stateSub = _sharedPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {});
    });

    _syncWithAppState();

    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _togglePlay();
        }
      });
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

    try {
      await _sharedPlayer.setVolume(mute ? 0.0 : 1.0);
    } catch (e) {
      debugPrint('Error setting volume: $e');
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _toggleMute() {
    _setMute(!_isMuted);
  }

  Future<void> _togglePlay() async {
    if (widget.audioUrl.trim().isEmpty) return;

    if (_activePlayerState == this) {
      try {
        if (_sharedPlayer.state == ap.PlayerState.playing) {
          await _sharedPlayer.pause();
        } else {
          await _sharedPlayer.resume();
        }
      } catch (e) {
        debugPrint('Error toggle play: $e');
      }
    } else {
      try {
        await _sharedPlayer.stop();
      } catch (_) {}

      final oldActive = _activePlayerState;
      _activePlayerState = this;
      oldActive?.setState(() {});

      ap.Source source;
      final String url = widget.audioUrl;
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

      _position = Duration.zero;
      _duration = Duration.zero;

      try {
        await _sharedPlayer.play(source);
      } catch (e) {
        debugPrint('Error playing audio: $e');
      }
    }
    setState(() {});
  }

  void _seekRelative(int seconds) {
    if (_activePlayerState != this) return;
    Duration newPos = _position + Duration(seconds: seconds);

    if (newPos < Duration.zero) {
      newPos = Duration.zero;
    }

    if (newPos > _duration) {
      newPos = _duration;
    }

    _sharedPlayer.seek(newPos);
  }

  void _seekTo(double value) {
    if (_activePlayerState != this) return;
    _sharedPlayer.seek(Duration(seconds: value.toInt()));
  }

  @override
  void dispose() {
    _posSub?.cancel();

    _durSub?.cancel();

    _stateSub?.cancel();

    if (_appStateListener != null) {
      FFAppState().removeListener(_appStateListener!);
    }

    if (_activePlayerState == this) {
      _sharedPlayer.stop();
      _activePlayerState = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = _activePlayerState == this;

    final bool isRouteCurrent = ModalRoute.of(context)?.isCurrent ?? true;
    if (!isRouteCurrent && isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_activePlayerState == this) {
          _sharedPlayer.stop();
          _activePlayerState = null;
        }
      });
    }

    final ap.PlayerState currentState =
        isActive ? _sharedPlayer.state : ap.PlayerState.stopped;

    final maxSeconds = (isActive && _duration.inSeconds > 0)
        ? _duration.inSeconds.toDouble()
        : 1.0;

    final currentSeconds = (isActive)
        ? _position.inSeconds.toDouble().clamp(0.0, maxSeconds)
        : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          min: 0,
          max: maxSeconds,
          value: currentSeconds,
          onChanged: isActive ? _seekTo : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.replay_10),
              onPressed: isActive ? () => _seekRelative(-10) : null,
            ),
            IconButton(
              iconSize: 40,
              icon: Icon(
                (isActive && currentState == ap.PlayerState.playing)
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: _togglePlay,
            ),
            IconButton(
              icon: const Icon(Icons.forward_10),
              onPressed: isActive ? () => _seekRelative(10) : null,
            ),
          ],
        ),
      ],
    );
  }
}
