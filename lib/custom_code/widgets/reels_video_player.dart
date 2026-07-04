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
import '/flutter_flow/flutter_flow_youtube_player.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

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

  void _videoListener() {
    if (mounted) {
      setState(() {});
    }
  }

  bool _initialized = false;

  bool _muted = false;

  bool _hasError = false;

  bool _youtubePlaying = false;

  bool _isManuallyPaused = false;

  bool get _isYoutube =>
      widget.videoUrl.contains('youtube.com') ||
      widget.videoUrl.contains('youtu.be');

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    debugPrint(
        "ReelsVideoPlayer: Initializing with videoUrl = '${widget.videoUrl}'");
    if (_isYoutube) {
      if (mounted) {
        setState(() {
          _youtubePlaying = widget.isActive;
          _initialized = true;
          _hasError = false;
          _isManuallyPaused = false;
        });
      }
      return;
    }

    if (widget.videoUrl.isEmpty) {
      debugPrint("ReelsVideoPlayer: Error - videoUrl is empty");
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        _hasError = false;
      });
    }

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      _controller!.addListener(_videoListener);

      await _controller!.initialize();

      await _controller!.setLooping(true);

      if (!mounted) return;

      setState(() {
        _initialized = true;
      });

      // 🔥 SAFE AUTOPLAY (FIXED)

      _applyPlayState();
    } catch (e, stackTrace) {
      debugPrint(
          "ReelsVideoPlayer: Error initializing video player for URL '${widget.videoUrl}': $e");
      debugPrint(stackTrace.toString());
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant ReelsVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
      _controller = null;

      _initialized = false;
      _isManuallyPaused = false;

      _init();

      return;
    }

    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        _isManuallyPaused = false;
        _youtubePlaying = true;
      } else {
        _youtubePlaying = false;
      }
    }

    if (_isYoutube) {
      return;
    }

    if (!_initialized || _controller == null) return;

    // 🔥 DIRECT CONTROL (NO postFrame delay)

    _applyPlayState();
  }

  void _applyPlayState() {
    if (_controller == null) return;

    if (widget.isActive && !_isManuallyPaused) {
      if (!_controller!.value.isPlaying) {
        _controller!.play();
      }
    } else {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      }
    }
  }

  void _togglePlayPause() {
    debugPrint(
        "ReelsVideoPlayer: _togglePlayPause called, isYoutube = $_isYoutube");
    if (_isYoutube) {
      setState(() {
        _youtubePlaying = !_youtubePlaying;
        _isManuallyPaused = !_youtubePlaying;
        debugPrint(
            "ReelsVideoPlayer: Toggled _youtubePlaying to $_youtubePlaying");
      });
      return;
    }

    if (_controller == null) {
      debugPrint("ReelsVideoPlayer: _controller is null");
      return;
    }

    setState(() {
      if (_controller!.value.isPlaying) {
        debugPrint("ReelsVideoPlayer: Pausing native video player");
        _controller!.pause();
        _isManuallyPaused = true;
      } else {
        debugPrint("ReelsVideoPlayer: Playing native video player");
        _controller!.play();
        _isManuallyPaused = false;
      }
    });
  }

  void _toggleMute() {
    if (_isYoutube) {
      setState(() {
        _muted = !_muted;
      });
      return;
    }

    if (_controller == null) return;

    setState(() {
      _muted = !_muted;

      _controller!.setVolume(_muted ? 0 : 1);
    });
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final height = constraints.maxHeight;

          if (_hasError) {
            return Container(
              width: width,
              height: height,
              color: Colors.black87,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: Colors.redAccent,
                      size: 42,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Kunde inte ladda video',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Servern begränsar förfrågningar (429)',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final playIconSize = (width < height ? width : height) * 0.25;

          if (_isYoutube) {
            return GestureDetector(
              onTap: _togglePlayPause,
              onDoubleTap: _toggleMute,
              child: Container(
                width: width,
                height: height,
                color: Colors.black,
                child: SafeArea(
                  top: true,
                  bottom: false,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 1600.0,
                          height: 900.0,
                          child: FlutterFlowYoutubePlayer(
                            url: widget.videoUrl,
                            width: 1600.0,
                            height: 900.0,
                            autoPlay: _youtubePlaying,
                            looping: true,
                            mute: _muted,
                            showControls: false,
                            showFullScreen: false,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: PointerInterceptor(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _togglePlayPause,
                            onDoubleTap: _toggleMute,
                            child: Container(
                              color: Colors.black.withOpacity(0.01),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

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
              child: SafeArea(
                top: false,
                bottom: false,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // 🔥 TRUE FULLSCREEN (constraint-safe)

                    FittedBox(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: _controller!.value.size.width > 0
                            ? _controller!.value.size.width
                            : 16.0,
                        height: _controller!.value.size.height > 0
                            ? _controller!.value.size.height
                            : 9.0,
                        child: VideoPlayer(_controller!),
                      ),
                    ),

                    if (!_controller!.value.isPlaying)
                      Center(
                        child: Container(
                          width: 64.0,
                          height: 64.0,
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
