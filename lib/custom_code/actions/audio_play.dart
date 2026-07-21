// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:audioplayers/audioplayers.dart';
import '/flutter_flow/nav/nav.dart';

final AudioPlayer _audioPlayer = AudioPlayer();
bool _isLifecycleObserverRegistered = false;
Route? _lastObservedRoute;

class AudioAppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _audioPlayer.stop();
    }
  }
}

Future audioPlay(String audioLink) async {
  // Add your function code here!

  try {
    if (audioLink.isEmpty) {
      return;
    }

    // Register app lifecycle observer to stop audio when app is minimized or closed
    if (!_isLifecycleObserverRegistered) {
      WidgetsBinding.instance.addObserver(AudioAppLifecycleObserver());
      _isLifecycleObserverRegistered = true;
    }

    await _audioPlayer.stop();

    // Find the current active route (e.g. the bottom sheet route)
    // and automatically stop audio when it is dismissed/popped.
    Route? activeRoute;
    appNavigatorKey.currentState?.popUntil((route) {
      activeRoute = route;
      return true; // do not pop
    });

    if (activeRoute != null && activeRoute != _lastObservedRoute) {
      _lastObservedRoute = activeRoute;
      activeRoute!.popped.then((_) {
        _audioPlayer.stop();
        if (_lastObservedRoute == activeRoute) {
          _lastObservedRoute = null;
        }
      });
    }

    final String assetPath = 'audios/$audioLink.mp3';

    print(assetPath);

    await _audioPlayer.play(AssetSource(assetPath));
  } catch (e) {
    debugPrint('Error playing audio: $e');
  }
}
