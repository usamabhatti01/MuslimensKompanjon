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
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';

class ReelsVideoPlayer extends StatefulWidget {
  const ReelsVideoPlayer({
    super.key,
    this.width,
    this.height,
    required this.videoUrl,
    this.isActive,
  });

  final double? width;
  final double? height;
  final String videoUrl;
  final bool? isActive;

  @override
  State<ReelsVideoPlayer> createState() => _ReelsVideoPlayerState();
}

class _ReelsVideoPlayerState extends State<ReelsVideoPlayer>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  VideoPlayerController? _controller;
  YoutubePlayerController? _youtubeController;

  // Only ONE video plays at a time across the whole app.
  static final ValueNotifier<_ReelsVideoPlayerState?> _activePlayer =
      ValueNotifier(null);

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
  bool _isCurrentlyVisible = false;
  ScrollPosition? _scrollPosition;

  bool get _isYoutube =>
      widget.videoUrl.contains('youtube.com') ||
      widget.videoUrl.contains('youtu.be');

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isCurrentlyVisible = false;
    _init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newPosition = Scrollable.maybeOf(context)?.position;
    if (newPosition != _scrollPosition) {
      _scrollPosition?.removeListener(_onScroll);
      _scrollPosition = newPosition;
      _scrollPosition?.addListener(_onScroll);
    }

    // Pause immediately if this route is no longer the top-most one
    // (i.e. the user navigated to another page).
    final isRouteActive = ModalRoute.of(context)?.isCurrent ?? true;
    if (!isRouteActive) {
      _pauseAll();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _onScroll() {
    _checkVisibility();
  }

  bool _determineIsActive() {
    if (!mounted) return false;
    final isRouteActive = ModalRoute.of(context)?.isCurrent ?? true;
    if (!isRouteActive) return false;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return false;

    final globalOffset = renderBox.localToGlobal(Offset.zero);
    if (globalOffset.dx.isNaN ||
        globalOffset.dx.isInfinite ||
        globalOffset.dy.isNaN ||
        globalOffset.dy.isInfinite) return false;

    final size = renderBox.size;
    if (size.height <= 0) return false;
    final screenHeight = MediaQuery.sizeOf(context).height;

    // Compute how many pixels of the widget are within the viewport.
    final double top = globalOffset.dy;
    final double bottom = top + size.height;
    final double visibleTop = top.clamp(0.0, screenHeight);
    final double visibleBottom = bottom.clamp(0.0, screenHeight);
    final double visibleHeight = visibleBottom - visibleTop;

    // Require at least 60% of the widget to be visible.
    return visibleHeight / size.height >= 0.60;
  }

  void _checkVisibility() {
    if (!mounted) return;
    final active = _determineIsActive();

    if (active != _isCurrentlyVisible) {
      setState(() {
        _isCurrentlyVisible = active;
        if (!_isCurrentlyVisible) {
          _isManuallyPaused = false;
          // Release the global active-player slot if we hold it.
          if (_activePlayer.value == this) {
            _activePlayer.value = null;
          }
          if (_isYoutube) {
            _youtubeController?.close();
            _youtubeController = null;
            _youtubePlaying = false;
          }
        }
      });

      if (_isCurrentlyVisible) {
        // Pause whoever was playing before and claim the slot.
        final previous = _activePlayer.value;
        if (previous != null && previous != this) {
          previous._pauseAll();
        }
        _activePlayer.value = this;

        if (_isYoutube && _youtubeController == null) {
          _initYoutubePlayer();
        } else {
          _applyPlayState();
        }
      } else {
        _applyPlayState();
      }
    }
  }

  String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();
    for (final regex in [
      RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$",
      ),
      RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$",
      ),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      final match = regex.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }
    return null;
  }

  void _initYoutubePlayer() {
    final videoId = _convertUrlToId(widget.videoUrl);
    if (videoId == null) return;

    if (mounted) {
      setState(() {
        _hasError = false;
      });
    }

    _youtubeController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: !_isManuallyPaused,
      params: const YoutubePlayerParams(
        origin: 'https://www.youtube-nocookie.com',
        mute: false,
        loop: true,
        showControls: false,
        showFullscreenButton: false,
        strictRelatedVideos: false,
      ),
    );

    _youtubeController!.stream.listen((value) {
      if (!mounted) return;
      if (_isCurrentlyVisible && !_isManuallyPaused) {
        if (value.playerState == PlayerState.playing) {
          if (!_youtubePlaying) {
            setState(() {
              _youtubePlaying = true;
            });
          }
        } else if (value.playerState == PlayerState.paused) {
          if (_youtubePlaying) {
            setState(() {
              _youtubePlaying = false;
            });
          }
        }
      }
    });

    _youtubePlaying = !_isManuallyPaused;
  }

  void _init() async {
    debugPrint(
        "ReelsVideoPlayer: Initializing with videoUrl = '${widget.videoUrl}'");
    if (_isYoutube) {
      if (_isCurrentlyVisible) {
        _initYoutubePlayer();
      }
      if (mounted) {
        setState(() {
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
      _scrollPosition?.removeListener(_onScroll);
      _scrollPosition = null;
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
      _controller = null;
      _youtubeController?.close();
      _youtubeController = null;

      _initialized = false;
      _isManuallyPaused = false;

      _init();
      return;
    }

    _applyPlayState();
  }

  void _applyPlayState() {
    final bool active = _isCurrentlyVisible;

    if (_isYoutube) {
      if (_youtubeController == null) return;
      if (active && !_isManuallyPaused) {
        _youtubeController!.playVideo();
        if (!_youtubePlaying) {
          setState(() {
            _youtubePlaying = true;
          });
        }
      } else {
        _youtubeController!.pauseVideo();
        if (_youtubePlaying) {
          setState(() {
            _youtubePlaying = false;
          });
        }
      }
      return;
    }

    if (_controller == null) return;

    if (active && !_isManuallyPaused) {
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
      if (_youtubeController == null) return;
      setState(() {
        if (_youtubePlaying) {
          debugPrint("ReelsVideoPlayer: Pausing YouTube video player");
          _youtubeController!.pauseVideo();
          _youtubePlaying = false;
          _isManuallyPaused = true;
        } else {
          debugPrint("ReelsVideoPlayer: Playing YouTube video player");
          _youtubeController!.playVideo();
          _youtubePlaying = true;
          _isManuallyPaused = false;
        }
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
    setState(() {
      _muted = !_muted;
      if (_isYoutube) {
        if (_youtubeController != null) {
          if (_muted) {
            _youtubeController!.mute();
          } else {
            _youtubeController!.unMute();
          }
        }
      } else {
        _controller?.setVolume(_muted ? 0 : 1);
      }
    });
  }

  // ── App lifecycle ─────────────────────────────────────────────────────────

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        _pauseAll();
        break;
      case AppLifecycleState.resumed:
        if (_isCurrentlyVisible && !_isManuallyPaused) {
          _applyPlayState();
        }
        break;
      default:
        break;
    }
  }

  /// Pauses whichever player is active without changing _isManuallyPaused.
  void _pauseAll() {
    if (_isYoutube) {
      _youtubeController?.pauseVideo();
      if (_youtubePlaying && mounted) setState(() => _youtubePlaying = false);
    } else {
      if (_controller?.value.isPlaying == true) {
        _controller?.pause();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Release global slot only if we currently hold it.
    if (_activePlayer.value == this) {
      _activePlayer.value = null;
    }
    _scrollPosition?.removeListener(_onScroll);
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    _youtubeController?.close();
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

          if (_isYoutube) {
            final videoId = _convertUrlToId(widget.videoUrl);
            final thumbnailUrl = videoId != null
                ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
                : '';

            if (!_isCurrentlyVisible || _youtubeController == null) {
              return Container(
                width: width,
                height: height,
                color: Colors.black,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (thumbnailUrl.isNotEmpty)
                      Image.network(
                        thumbnailUrl,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
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
              );
            }

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
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
                          child: YoutubePlayer(
                            controller: _youtubeController!,
                            gestureRecognizers: const <Factory<
                                TapGestureRecognizer>>{},
                            enableFullScreenOnVerticalDrag: false,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 80.0,
                          height: 35.0,
                          color: Colors.black,
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
            behavior: HitTestBehavior.opaque,
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
