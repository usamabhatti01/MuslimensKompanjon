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

import 'package:video_player/video_player.dart';

class ReelsVideoPlayer extends StatefulWidget {
  const ReelsVideoPlayer({
    super.key,
    this.width,
    this.height,
    required this.videoUrl,
    required this.isActive,
  });

  final double? width;

  final double? height;

  final String videoUrl;

  final bool isActive;

  @override
  State<ReelsVideoPlayer> createState() => _ReelsVideoPlayerState();
}

class _ReelsVideoPlayerState extends State<ReelsVideoPlayer>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;

  bool _initialized = false;

  bool _muted = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    await _controller!.initialize();

    await _controller!.setLooping(true);

    if (!mounted) return;

    setState(() {
      _initialized = true;
    });

    // 🔥 SAFE AUTOPLAY (FIXED)

    _applyPlayState();
  }

  @override
  void didUpdateWidget(covariant ReelsVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller?.dispose();

      _initialized = false;

      _init();

      return;
    }

    if (!_initialized || _controller == null) return;

    // 🔥 DIRECT CONTROL (NO postFrame delay)

    _applyPlayState();
  }

  void _applyPlayState() {
    if (_controller == null) return;

    if (widget.isActive) {
      _controller!.play();
    } else {
      _controller!.pause();
    }
  }

  void _togglePlayPause() {
    if (_controller == null) return;

    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    });
  }

  void _toggleMute() {
    if (_controller == null) return;

    setState(() {
      _muted = !_muted;

      _controller!.setVolume(_muted ? 0 : 1);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final height = constraints.maxHeight;

        if (!_initialized ||
            _controller == null ||
            !_controller!.value.isInitialized) {
          return SizedBox(
            width: width,
            height: height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return GestureDetector(
          onTap: _togglePlayPause,
          onDoubleTap: _toggleMute,
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 🔥 TRUE FULLSCREEN (constraint-safe)

                FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: _controller!.value.size.width,
                    height: _controller!.value.size.height,
                    child: VideoPlayer(_controller!),
                  ),
                ),

                if (!_controller!.value.isPlaying)
                  const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),

                Positioned(
                  top: 60,
                  right: 20,
                  child: Icon(
                    _muted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
