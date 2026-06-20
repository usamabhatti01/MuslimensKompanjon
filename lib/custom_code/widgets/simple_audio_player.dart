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

import 'package:just_audio/just_audio.dart';
import 'dart:async';

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
  late AudioPlayer _player;

  Duration _duration = Duration.zero;

  Duration _position = Duration.zero;

  bool _isMuted = false;

  StreamSubscription? _posSub;

  StreamSubscription? _durSub;

  VoidCallback? _appStateListener;

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer();

    _init();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncWithAppState();
    });
  }

  // ---------------- INIT ----------------

  Future<void> _init() async {
    try {
      await _player.setUrl(widget.audioUrl);

      _durSub = _player.durationStream.listen((d) {
        if (!mounted) return;

        setState(() {
          _duration = d ?? Duration.zero;
        });
      });

      _posSub = _player.positionStream.listen((p) {
        if (!mounted) return;

        setState(() {
          _position = p;
        });
      });

      _applyAppMuteState();
    } catch (e) {
      debugPrint("Audio init error: $e");
    }
  }

  // ---------------- APP STATE SYNC ----------------

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

  // ---------------- MUTE ----------------

  void _setMute(bool mute) {
    if (!mounted) return;

    _isMuted = mute;

    _player.setVolume(mute ? 0.0 : 1.0);

    setState(() {});
  }

  void _toggleMute() {
    _setMute(!_isMuted);
  }

  // ---------------- PLAY / PAUSE ----------------

  void _togglePlay() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }

    if (!mounted) return;

    setState(() {});
  }

  // ---------------- SEEK ----------------

  void _seekRelative(int seconds) {
    final newPos = _position + Duration(seconds: seconds);

    _player.seek(newPos);
  }

  void _seekTo(double value) {
    _player.seek(Duration(seconds: value.toInt()));
  }

  // ---------------- DISPOSE ----------------

  @override
  void dispose() {
    _posSub?.cancel();

    _durSub?.cancel();

    if (_appStateListener != null) {
      FFAppState().removeListener(_appStateListener!);
    }

    _player.dispose();

    super.dispose();
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    final maxSeconds = _duration.inSeconds.toDouble() > 0
        ? _duration.inSeconds.toDouble()
        : 1.0;

    final currentSeconds =
        _position.inSeconds.toDouble().clamp(0.0, maxSeconds);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PROGRESS BAR

        Slider(
          min: 0,
          max: maxSeconds,
          value: currentSeconds,
          onChanged: _seekTo,
        ),

        // CONTROLS

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.replay_10),
              onPressed: () => _seekRelative(-10),
            ),
            IconButton(
              icon: Icon(
                _player.playing ? Icons.pause : Icons.play_arrow,
              ),
              iconSize: 40,
              onPressed: _togglePlay,
            ),
            IconButton(
              icon: const Icon(Icons.forward_10),
              onPressed: () => _seekRelative(10),
            ),
            // IconButton(
            //   icon: Icon(
            //     _isMuted ? Icons.volume_off : Icons.volume_up,
            //   ),
            //   onPressed: _toggleMute,
            // ),
          ],
        ),
      ],
    );
  }
} //
