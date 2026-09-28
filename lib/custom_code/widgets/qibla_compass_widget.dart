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
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:vibration/vibration.dart';

class QiblaStrings {
  static const Map<String, Map<String, String>> values = {
    'en': {
      'calibrate':
          'Calibrate the compass by moving the phone in a figure eight (8)',
      'searchQibla': 'Search Qibla',
      'facingQibla': 'Facing Qibla',
      'fetching': 'Fetching location...',
      'disabled': 'Location services disabled',
      'permission': 'Location permission denied',
    },
    'sv': {
      'calibrate': 'Kalibrera kompassen genom att röra telefonen i en åtta (8)',
      'searchQibla': 'Sök Qibla',
      'facingQibla': 'Riktning mot Qibla',
      'fetching': 'Hämtar plats...',
      'disabled': 'Platstjänster är avstängda',
      'permission': 'Platsbehörighet nekad',
    },
  };
}

class QiblaCompassWidget extends StatefulWidget {
  const QiblaCompassWidget({
    super.key,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  @override
  State<QiblaCompassWidget> createState() => _QiblaCompassWidgetState();
}

class _QiblaCompassWidgetState extends State<QiblaCompassWidget>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver, RouteAware {
  double? _heading;
  double? _qiblaDirection;
  bool _isAligned = false;
  bool _hasVibrated = false;
  bool _isLowAccuracy = false;
  ui.Image? _kaabaImage;
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentAnimAngle = 0.0;
  final ValueNotifier<double> _displayHeading = ValueNotifier<double>(0.0);
  StreamSubscription<CompassEvent>? _compassSubscription;
  String _instruction = 'fetching';
  ModalRoute<dynamic>? _route;

  String _translate(String key) {
    String lang = 'en';
    try {
      if (mounted) {
        lang = FFLocalizations.of(context).languageCode;
      }
    } catch (_) {}
    if (lang.startsWith('sv')) {
      lang = 'sv';
    } else {
      lang = 'en';
    }
    final translationMap =
        QiblaStrings.values[lang] ?? QiblaStrings.values['en']!;
    return translationMap[key] ?? key;
  }

  String _getLanguageCode() {
    String lang = 'en';
    try {
      if (mounted) {
        lang = FFLocalizations.of(context).languageCode;
      }
    } catch (_) {}
    return lang;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadKaabaImage();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    )..addListener(() {
        _currentAnimAngle = _animation.value;
        _displayHeading.value = (_animation.value % 360 + 360) % 360;
      });

    // Instantly initialize Qibla direction from user's selected city/app state
    _initFromAppState();

    // Start compass sensor immediately so there is zero initial delay
    _startCompass();
    _init();
  }

  void _initFromAppState() {
    try {
      final userCityName = FFAppState().user.city;
      if (userCityName.isNotEmpty) {
        final match = FFAppState().cityList.firstWhere(
              (c) => c.name.toLowerCase() == userCityName.toLowerCase(),
              orElse: () => FFAppState().cityList.isNotEmpty
                  ? FFAppState().cityList.first
                  : CityRecordStruct(
                      name: 'Stockholm',
                      lat: 59.3293,
                      lng: 18.0686,
                    ),
            );
        if (match.lat != 0.0 && match.lng != 0.0) {
          _qiblaDirection = Qibla(Coordinates(match.lat, match.lng)).direction;
        }
      } else if (FFAppState().cityList.isNotEmpty) {
        final firstCity = FFAppState().cityList.first;
        if (firstCity.lat != 0.0 && firstCity.lng != 0.0) {
          _qiblaDirection =
              Qibla(Coordinates(firstCity.lat, firstCity.lng)).direction;
        }
      } else {
        // Default to Sweden (Stockholm)
        _qiblaDirection = Qibla(Coordinates(59.3293, 18.0686)).direction;
      }
    } catch (e) {
      _qiblaDirection = Qibla(Coordinates(59.3293, 18.0686)).direction;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != _route) {
      if (_route != null) {
        routeObserver.unsubscribe(this);
      }
      _route = route;
      if (route != null) {
        routeObserver.subscribe(this, route);
      }
    }
    if (route != null && !route.isCurrent) {
      _stopSensors();
    }
  }

  @override
  void didPush() {
    if (mounted) {
      final route = ModalRoute.of(context);
      if (route == null || route.isCurrent) {
        _startCompass();
      } else {
        _stopSensors();
      }
    }
  }

  @override
  void didPopNext() {
    if (mounted) {
      final route = ModalRoute.of(context);
      if (route == null || route.isCurrent) {
        _startCompass();
      } else {
        _stopSensors();
      }
    }
  }

  @override
  void didPushNext() {
    _stopSensors();
  }

  @override
  void didPop() {
    _stopSensors();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden) {
      _stopSensors();
    } else if (state == AppLifecycleState.resumed) {
      if (mounted) {
        final route = ModalRoute.of(context);
        if (route == null || route.isCurrent) {
          _startCompass();
        }
      }
    }
  }

  void _stopSensors() {
    _compassSubscription?.cancel();
    _compassSubscription = null;
    _isAligned = false;
    _hasVibrated = false;
    try {
      Vibration.cancel();
    } catch (_) {}
  }

  @override
  void deactivate() {
    _stopSensors();
    super.deactivate();
  }

  @override
  void dispose() {
    if (_route != null) {
      routeObserver.unsubscribe(this);
    }
    WidgetsBinding.instance.removeObserver(this);
    _stopSensors();
    _controller.dispose();
    _displayHeading.dispose();
    super.dispose();
  }

  Future<void> _loadKaabaImage() async {
    try {
      final data = await rootBundle.load(
        'assets/images/kaba.png',
      );
      final bytes = data.buffer.asUint8List();
      final codec = await ui.instantiateImageCodec(
        bytes,
      );
      final frame = await codec.getNextFrame();
      if (mounted) {
        setState(() {
          _kaabaImage = frame.image;
        });
      }
    } catch (e) {
      debugPrint("Error loading kaaba asset: $e");
    }
  }

  Future<void> _init() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          _instruction = 'disabled';
        });
      }
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _instruction = 'permission';
        });
      }
      return;
    }

    // 1. Instantly use cached/last known position if available
    Position? position;
    try {
      position = await Geolocator.getLastKnownPosition();
      if (position != null && mounted) {
        final qibla = Qibla(
          Coordinates(
            position.latitude,
            position.longitude,
          ),
        ).direction;
        setState(() {
          _qiblaDirection = qibla;
        });
      }
    } catch (e) {
      debugPrint("Error getting last known position: $e");
    }

    // 2. Fetch fresh high/medium accuracy position in background
    try {
      final freshPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 4),
        ),
      );
      if (mounted) {
        final qibla = Qibla(
          Coordinates(
            freshPosition.latitude,
            freshPosition.longitude,
          ),
        ).direction;
        setState(() {
          _qiblaDirection = qibla;
        });
      }
    } catch (e) {
      debugPrint("Error getting current position: $e");
    }
  }

  Future<void> _triggerVibration() async {
    if (!mounted || _compassSubscription == null) return;
    final route = ModalRoute.of(context);
    if (route != null && !route.isCurrent) {
      _stopSensors();
      return;
    }
    try {
      HapticFeedback.vibrate();
      HapticFeedback.heavyImpact();
    } catch (_) {}

    try {
      final bool hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator && mounted && _compassSubscription != null) {
        final currentRoute = ModalRoute.of(context);
        if (currentRoute != null && !currentRoute.isCurrent) {
          _stopSensors();
          return;
        }
        final bool hasAmplitude = await Vibration.hasAmplitudeControl();
        if (hasAmplitude) {
          await Vibration.vibrate(duration: 400, amplitude: 128);
        } else {
          await Vibration.vibrate(duration: 400);
        }
      }
    } catch (_) {}
  }

  void _startCompass() {
    _compassSubscription?.cancel();
    final stream = FlutterCompass.events;
    if (stream == null) return;
    _compassSubscription = stream.listen((CompassEvent event) {
      if (!mounted) {
        _stopSensors();
        return;
      }
      final route = ModalRoute.of(context);
      if (route != null && !route.isCurrent) {
        _stopSensors();
        return;
      }

      final heading = event.heading;
      if (heading == null) return;
      final rawTarget = (heading % 360 + 360) % 360;

      // Accuracy detection (State 1 vs normal)
      bool lowAccuracy = false;
      if (event.accuracy == null) {
        // Null accuracy indicates uncalibrated or unreliable sensor on Android/iOS
        lowAccuracy = true;
      } else {
        final acc = event.accuracy!;
        if (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS) {
          // iOS: headingAccuracy in degrees (< 0 is invalid/uncalibrated, > 15.0 is low accuracy)
          if (acc < 0 || acc > 15.0) {
            lowAccuracy = true;
          }
        } else if (defaultTargetPlatform == TargetPlatform.android) {
          // Android via flutter_compass plugin:
          // SENSOR_STATUS_ACCURACY_HIGH = 15.0
          // SENSOR_STATUS_ACCURACY_MEDIUM = 30.0
          // SENSOR_STATUS_ACCURACY_LOW = 45.0
          // UNRELIABLE / UNKNOWN = -1.0
          if (acc < 0 || acc >= 40.0 || (acc <= 1.0 && acc >= 0)) {
            lowAccuracy = true;
          }
        } else {
          // General fallback
          if (acc < 0 || acc > 15.0) {
            lowAccuracy = true;
          }
        }
      }

      // Calculate shortest angular delta across 0°/360° boundary
      double currentNormalized = (_currentAnimAngle % 360 + 360) % 360;
      double delta = ((rawTarget - currentNormalized + 540) % 360) - 180;
      double targetAngle = _currentAnimAngle + delta;

      // Animate smoothly and quickly to target
      _animation = Tween<double>(
        begin: _currentAnimAngle,
        end: targetAngle,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );
      _controller
        ..reset()
        ..forward();

      // Check alignment
      bool alignedNow = false;
      if (_qiblaDirection != null) {
        double diff = ((_qiblaDirection! - rawTarget) + 540) % 360 - 180;
        alignedNow = diff.abs() <= 5.0;
        if (alignedNow && !_hasVibrated) {
          _hasVibrated = true;
          _triggerVibration();
        } else if (!alignedNow) {
          _hasVibrated = false;
        }
      }

      _heading = rawTarget;

      // Only trigger widget rebuild if discrete UI state changed
      if (_isAligned != alignedNow || _isLowAccuracy != lowAccuracy) {
        debugPrint(
            'Qibla state change: isLowAccuracy=$lowAccuracy (raw accuracy=${event.accuracy}), isAligned=$alignedNow');
        setState(() {
          _isAligned = alignedNow;
          _isLowAccuracy = lowAccuracy;
        });
      }
    });
  }

  Widget _buildAlertBanner() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Determine 3 dynamic states
    IconData iconData;
    String bannerText;
    bool isBoldGreenText = false;

    if (_isLowAccuracy) {
      // State 1: Low Sensor Accuracy / Calibration needed
      iconData = Icons.all_inclusive_rounded;
      bannerText = _translate('calibrate');
    } else if (!_isAligned) {
      // State 2: Out of Alignment / Searching
      iconData = Icons.search_rounded;
      bannerText = _translate('searchQibla');
    } else {
      // State 3: Exact Alignment <= +/-5°
      iconData = Icons.explore_rounded;
      bannerText = _translate('facingQibla');
      isBoldGreenText = true;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0x1A2ECC71) : const Color(0xFFEAF5EA),
        border: Border.all(
          color: isDark ? const Color(0x332ECC71) : const Color(0xFFC8E6C9),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark ? const Color(0x2B2ECC71) : const Color(0xFFD4EED8),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                iconData,
                color:
                    isDark ? const Color(0xFF2ECC71) : const Color(0xFF0B7A12),
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Align(
              alignment:
                  (_isLowAccuracy) ? Alignment.centerLeft : Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  right: (_isLowAccuracy) ? 0 : 40.0,
                ),
                child: Text(
                  bannerText,
                  textAlign: _isLowAccuracy ? TextAlign.left : TextAlign.center,
                  style: TextStyle(
                    fontSize: isBoldGreenText ? 17 : (_isLowAccuracy ? 13 : 15),
                    color: isBoldGreenText
                        ? (isDark
                            ? const Color(0xFF2ECC71)
                            : const Color(0xFF0B7A12))
                        : (isDark ? Colors.white : Colors.black87),
                    fontWeight: isBoldGreenText
                        ? FontWeight.w700
                        : (_isLowAccuracy ? FontWeight.w500 : FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top section (Dynamic 3-state Alert banner or loader)
          Column(
            children: [
              if (_heading == null || _qiblaDirection == null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _translate(_instruction),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.secondaryText,
                    ),
                  ),
                )
              else
                _buildAlertBanner(),
            ],
          ),
          // Middle section (Compass Dial)
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compassSize =
                      math.min(constraints.maxWidth, constraints.maxHeight) *
                          0.88;
                  return SizedBox(
                    width: compassSize,
                    height: compassSize,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _CompassPainter(
                            heading: _animation.value,
                            qiblaDirection: _qiblaDirection ?? 0,
                            kaabaImage: _kaabaImage,
                            languageCode: _getLanguageCode(),
                            compassColor: theme.primary,
                            labelColor: theme.primaryText,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          // Bottom section: Dynamic Degree Counter & Vibration waves
          Padding(
            padding:
                const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: _isAligned ? 1.0 : 0.0,
                  child: Text(
                    '((   ',
                    style: TextStyle(
                      fontSize: 26,
                      color: isDark
                          ? const Color(0x66FFFFFF)
                          : const Color(0xFFB0B0B0),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                ValueListenableBuilder<double>(
                  valueListenable: _displayHeading,
                  builder: (context, headingVal, _) {
                    return Text(
                      '${headingVal.round()}°',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: theme.primary,
                      ),
                    );
                  },
                ),
                Opacity(
                  opacity: _isAligned ? 1.0 : 0.0,
                  child: Text(
                    '   ))',
                    style: TextStyle(
                      fontSize: 26,
                      color: isDark
                          ? const Color(0x66FFFFFF)
                          : const Color(0xFFB0B0B0),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  final double heading;
  final double qiblaDirection;
  final ui.Image? kaabaImage;
  final String languageCode;
  final Color compassColor;
  final Color labelColor;

  _CompassPainter({
    required this.heading,
    required this.qiblaDirection,
    required this.kaabaImage,
    required this.languageCode,
    required this.compassColor,
    required this.labelColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final green = compassColor;
    final cx = size.width / 2;
    final cy = size.height / 2;
    final baseSize = math.min(size.width, size.height);
    final scale = (baseSize / 280.0).clamp(0.65, 1.4);
    final radius = baseSize / 2 - (24.0 * scale);

    // 1. Fixed Outer circle guide
    final circlePaint = Paint()
      ..color = green
      ..style = PaintingStyle.stroke
      ..strokeWidth = (5.0 * scale).clamp(3.5, 6.0);
    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      circlePaint,
    );

    // 2. Dynamic Rotating Dial (Cardinal Directions N, E, S, W & Accent Dots)
    // The dial rotates dynamically by -heading so that 'N' always points to true North
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(-heading * math.pi / 180);

    // 2a. Accent Dots at 45°, 135°, 225°, 315° on the rotating dial
    final dotPaint = Paint()
      ..color = green
      ..style = PaintingStyle.fill;
    final dotAngles = [45.0, 135.0, 225.0, 315.0];
    final dotDistance = radius - (15.0 * scale);
    final dotRadius = (3.5 * scale).clamp(2.5, 4.5);
    for (double deg in dotAngles) {
      final rad = (deg - 90) * math.pi / 180;
      final dx = dotDistance * math.cos(rad);
      final dy = dotDistance * math.sin(rad);
      canvas.drawCircle(
        Offset(dx, dy),
        dotRadius,
        dotPaint,
      );
    }

    // 2b. Dynamic Cardinal Letters (N, E, S, W) rotating with the compass dial
    final labelDistance =
        (radius * 0.65).clamp(radius - 40 * scale, radius - 24 * scale);
    final labelFontSize = (17.0 * scale).clamp(12.0, 20.0);

    final labels = [
      {
        'text': 'N',
        'x': 0.0,
        'y': -labelDistance,
        'isNorth': true,
      },
      {
        'text': 'E',
        'x': labelDistance,
        'y': 0.0,
        'isNorth': false,
      },
      {
        'text': 'S',
        'x': 0.0,
        'y': labelDistance,
        'isNorth': false,
      },
      {
        'text': 'W',
        'x': -labelDistance,
        'y': 0.0,
        'isNorth': false,
      },
    ];

    for (final item in labels) {
      final isNorth = item['isNorth'] as bool;
      final tp = TextPainter(
        text: TextSpan(
          text: item['text'] as String,
          style: TextStyle(
            fontSize: labelFontSize,
            color: isNorth ? green : labelColor,
            fontWeight: isNorth ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          (item['x'] as double) - tp.width / 2,
          (item['y'] as double) - tp.height / 2,
        ),
      );
    }

    canvas.restore();

    // 3. Dynamic Central Green Needle pointing towards Qibla
    // When heading aligns with qiblaDirection (diff == 0), needleAngle points straight up (-90 deg / 12 o'clock)
    double diff = ((qiblaDirection - heading) + 540) % 360 - 180;
    // Auto-snap micro-jitter within 1.5 deg
    if (diff.abs() <= 1.5) {
      diff = 0;
    }
    final needleAngle = (diff - 90) * math.pi / 180;

    final needleLength = radius - (44.0 * scale);
    final needleHalfBase = (10.0 * scale).clamp(7.0, 13.0);

    final tipX = cx + needleLength * math.cos(needleAngle);
    final tipY = cy + needleLength * math.sin(needleAngle);
    final leftX = cx + needleHalfBase * math.cos(needleAngle + math.pi / 2);
    final leftY = cy + needleHalfBase * math.sin(needleAngle + math.pi / 2);
    final rightX = cx + needleHalfBase * math.cos(needleAngle - math.pi / 2);
    final rightY = cy + needleHalfBase * math.sin(needleAngle - math.pi / 2);

    final needlePath = Path()
      ..moveTo(tipX, tipY)
      ..lineTo(leftX, leftY)
      ..lineTo(rightX, rightY)
      ..close();

    canvas.drawShadow(
      needlePath,
      Colors.black26,
      3 * scale,
      true,
    );
    canvas.drawPath(
      needlePath,
      Paint()
        ..color = green
        ..style = PaintingStyle.fill,
    );

    // 4. Center circular hub
    final hubOuterRadius = (16.0 * scale).clamp(12.0, 20.0);
    final hubInnerRadius = (13.0 * scale).clamp(10.0, 16.5);

    canvas.drawCircle(
      Offset(cx, cy),
      hubOuterRadius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(
            center: Offset(cx, cy),
            radius: hubOuterRadius,
          ),
        ),
      Colors.black26,
      2.5 * scale,
      true,
    );
    canvas.drawCircle(
      Offset(cx, cy),
      hubInnerRadius,
      Paint()
        ..color = green
        ..style = PaintingStyle.fill,
    );

    // 5. Fixed Kaaba asset in white circle badge above the outer circle at 12 o'clock
    final kaabaBadgeCenter = Offset(cx, cy - radius);
    final badgeRadius = (17.0 * scale).clamp(13.0, 21.0);

    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(
            center: kaabaBadgeCenter,
            radius: badgeRadius,
          ),
        ),
      Colors.black26,
      3 * scale,
      true,
    );
    canvas.drawCircle(
      kaabaBadgeCenter,
      badgeRadius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      kaabaBadgeCenter,
      badgeRadius,
      Paint()
        ..color = const Color(0xFFE8E8E8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    final kaabaImgSize = (24.0 * scale).clamp(18.0, 30.0);
    _drawKaabaAsset(
      canvas,
      kaabaBadgeCenter,
      kaabaImgSize,
    );

    // 6. Fixed Top Indicator Triangle pointing down towards Kaaba badge
    final arrowBaseHalf = (6.5 * scale).clamp(4.5, 8.5);
    final arrowHeight = (12.0 * scale).clamp(8.0, 15.0);
    final arrowTipY = cy - radius - badgeRadius - (3.0 * scale);
    final arrowBaseY = arrowTipY - arrowHeight;

    final topArrow = Path()
      ..moveTo(cx, arrowTipY)
      ..lineTo(cx - arrowBaseHalf, arrowBaseY)
      ..lineTo(cx + arrowBaseHalf, arrowBaseY)
      ..close();
    canvas.drawPath(
      topArrow,
      Paint()
        ..color = green
        ..style = PaintingStyle.fill,
    );
  }

  void _drawKaabaAsset(
    Canvas canvas,
    Offset center,
    double size,
  ) {
    if (kaabaImage == null) return;
    final rect = Rect.fromCenter(
      center: center,
      width: size,
      height: size,
    );
    paintImage(
      canvas: canvas,
      rect: rect,
      image: kaabaImage!,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }

  @override
  bool shouldRepaint(covariant _CompassPainter oldDelegate) {
    return oldDelegate.heading != heading ||
        oldDelegate.qiblaDirection != qiblaDirection ||
        oldDelegate.kaabaImage != kaabaImage ||
        oldDelegate.languageCode != languageCode ||
        oldDelegate.compassColor != compassColor ||
        oldDelegate.labelColor != labelColor;
  }
}
