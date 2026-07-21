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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
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
      'facingKaaba': 'You are facing the Kaaba',
      'deviceAngleLabel': 'Device angle relative to Qibla',
      'qiblaDirection': 'Facing Qibla',
      'vibrationLabel': 'vibration at exact direction',
      'fetching': 'Fetching location...',
      'disabled': 'Location services disabled',
      'permission': 'Location permission denied',
    },
    'sv': {
      'calibrate': 'Kalibrera kompassen genom att röra telefonen i en åtta (8)',
      'facingKaaba': 'Du är i riktning mot Kaba',
      'deviceAngleLabel': 'Enhetens vinkel i förhållande till Qibla',
      'qiblaDirection': 'Riktning mot Qibla',
      'vibrationLabel': 'vibration vid exakt riktning',
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
    with SingleTickerProviderStateMixin {
  double? _heading;
  double? _qiblaDirection;
  bool _isAligned = false;
  bool _hasVibrated = false;
  bool _showAlert = true;
  ui.Image? _kaabaImage;
  late AnimationController _controller;
  late Animation<double> _animation;
  StreamSubscription<CompassEvent>? _compassSubscription;
  String _instruction = 'fetching';
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
    _loadKaabaImage();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _init();
  }

  Future<void> _loadKaabaImage() async {
    final data = await rootBundle.load(
      'assets/images/kaba.png',
    );
    final bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(
      bytes,
    );
    final frame = await codec.getNextFrame();
    setState(() {
      _kaabaImage = frame.image;
    });
  }

  Future<void> _init() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _instruction = 'disabled';
      });
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        _instruction = 'permission';
      });
      return;
    }
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final qibla = Qibla(
      Coordinates(
        position.latitude,
        position.longitude,
      ),
    ).direction;
    setState(() {
      _qiblaDirection = qibla;
    });
    _startCompass();
  }

  void _triggerVibration() {
    try {
      // iOS Taptic Engine feedback (Double tap pattern for strong physical feel on iPhone)
      HapticFeedback.heavyImpact();
      Future.delayed(const Duration(milliseconds: 120), () {
        HapticFeedback.heavyImpact();
      });
      // System hardware vibration (Android & iOS AudioServices)
      Vibration.vibrate(duration: 400);
    } catch (_) {
      try {
        HapticFeedback.vibrate();
      } catch (_) {}
    }
  }

  void _startCompass() {
    final stream = FlutterCompass.events;
    if (stream == null) return;
    _compassSubscription = stream.listen((CompassEvent event) {
      final heading = event.heading;
      if (heading == null) return;
      final normalized = (heading % 360 + 360) % 360;

      if (_qiblaDirection != null) {
        double diff = ((_qiblaDirection! - normalized) + 540) % 360 - 180;
        final bool alignedNow = diff.abs() <= 5.0;
        if (alignedNow && !_hasVibrated) {
          _hasVibrated = true;
          _triggerVibration();
        } else if (!alignedNow) {
          _hasVibrated = false;
        }
        _isAligned = alignedNow;
      }

      _animation = Tween<double>(
        begin: _animation.value,
        end: normalized,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
        ),
      );
      _controller
        ..reset()
        ..forward();
      setState(() {
        _heading = normalized;
      });
    });
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAlertBanner() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0x1A2ECC71) : const Color(0xFFEAF5EA),
        border: Border.all(
          color: isDark ? const Color(0x332ECC71) : const Color(0xFFC8E6C9),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isDark ? const Color(0x1A2ECC71) : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isDark ? const Color(0x332ECC71) : const Color(0xFFC8E6C9),
              ),
            ),
            child: Center(
              child: Icon(
                _isAligned ? Icons.explore : Icons.gesture,
                color:
                    isDark ? const Color(0xFF2ECC71) : const Color(0xFF0B7A12),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _isAligned ? _translate('facingKaaba') : _translate('calibrate'),
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _showAlert = false;
              });
            },
            child: Icon(
              Icons.close,
              color: isDark ? Colors.white70 : Colors.black54,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillButton() {
    final theme = FlutterFlowTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: _isAligned ? 1.0 : 0.0,
          child: Text(
            '((   ',
            style: TextStyle(
              fontSize: 20,
              color: theme.secondaryText,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: theme.alternate, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFF2ECC71),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _translate('qiblaDirection'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.primaryText,
                ),
              ),
            ],
          ),
        ),
        Opacity(
          opacity: _isAligned ? 1.0 : 0.0,
          child: Text(
            '   ))',
            style: TextStyle(
              fontSize: 20,
              color: theme.secondaryText,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    // alignment check
    if (_heading != null && _qiblaDirection != null) {
      double diff = ((_qiblaDirection! - _heading!) + 540) % 360 - 180;
      final bool currentlyAligned = diff.abs() <= 5.0;
      if (currentlyAligned && !_hasVibrated) {
        _hasVibrated = true;
        _triggerVibration();
      } else if (!currentlyAligned) {
        _hasVibrated = false;
      }
      _isAligned = currentlyAligned;
    }
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top section (Alert banner or loader)
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
              else if (_showAlert)
                _buildAlertBanner(),
            ],
          ),
          // Middle section (Compass)
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compassSize =
                      math.min(constraints.maxWidth, constraints.maxHeight) *
                          0.85;
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
          // Bottom section (Angle, Pill, Vibration info)
          Padding(
            padding:
                const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Angle Text
                Text(
                  '${(_heading ?? 0).round()}°',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: theme.primary,
                  ),
                ),
                const SizedBox(height: 6),
                // Device Angle Label
                Text(
                  _translate('deviceAngleLabel'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                // Pill Button with Checkmark
                _buildPillButton(),
                const SizedBox(height: 8),
                // Vibration description
                Text(
                  _translate('vibrationLabel'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.secondaryText,
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
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final green = compassColor;
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = size.width / 2 - 20;
    // Outer circle
    final circlePaint = Paint()
      ..color = green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      circlePaint,
    );
    // Dots
    final dotPaint = Paint()
      ..color = green
      ..style = PaintingStyle.fill;
    final dotAngles = [
      45.0,
      135.0,
      225.0,
      315.0,
    ];
    for (double deg in dotAngles) {
      final rad = (deg - 90) * math.pi / 180;
      final dx = cx + (radius - 18) * math.cos(rad);
      final dy = cy + (radius - 18) * math.sin(rad);
      canvas.drawCircle(
        Offset(dx, dy),
        4,
        dotPaint,
      );
    }
    // Rotate letters
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(
      -heading * math.pi / 180,
    );
    canvas.translate(-cx, -cy);
    final labels = [
      {
        'text': 'N',
        'angle': -90.0,
      },
      {
        'text': 'E',
        'angle': 0.0,
      },
      {
        'text': 'S',
        'angle': 90.0,
      },
      {
        'text': 'W',
        'angle': 180.0,
      },
    ];
    for (final item in labels) {
      final angle = (item['angle'] as double) * math.pi / 180;
      final dx = cx + (radius - 38) * math.cos(angle);
      final dy = cy + (radius - 38) * math.sin(angle);
      final tp = TextPainter(
        text: TextSpan(
          text: item['text'] as String,
          style: TextStyle(
            fontSize: 18,
            color: labelColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          dx - tp.width / 2,
          dy - tp.height / 2,
        ),
      );
    }
    canvas.restore();
    // Kaaba asset
    _drawKaabaAsset(
      canvas,
      Offset(
        cx,
        cy - radius + 8,
      ),
    );
    // Top indicator
    final topArrow = Path()
      ..moveTo(
        cx,
        cy - radius - 18,
      )
      ..lineTo(
        cx - 8,
        cy - radius - 32,
      )
      ..lineTo(
        cx + 8,
        cy - radius - 32,
      )
      ..close();
    canvas.drawPath(
      topArrow,
      Paint()..color = green,
    );
    // Needle snap logic
    double diff = ((qiblaDirection - heading) + 540) % 360 - 180;
    // Auto snap
    if (diff.abs() <= 2) {
      diff = 0;
    }
    final needleAngle = diff * math.pi / 180 - math.pi / 2;
    final tipX = cx +
        (radius - 62) *
            math.cos(
              needleAngle,
            );
    final tipY = cy +
        (radius - 62) *
            math.sin(
              needleAngle,
            );
    final leftX = cx +
        12 *
            math.cos(
              needleAngle + math.pi / 2,
            );
    final leftY = cy +
        12 *
            math.sin(
              needleAngle + math.pi / 2,
            );
    final rightX = cx +
        12 *
            math.cos(
              needleAngle - math.pi / 2,
            );
    final rightY = cy +
        12 *
            math.sin(
              needleAngle - math.pi / 2,
            );
    final needlePath = Path()
      ..moveTo(tipX, tipY)
      ..lineTo(leftX, leftY)
      ..lineTo(rightX, rightY)
      ..close();
    canvas.drawShadow(
      needlePath,
      Colors.black26,
      4,
      true,
    );
    canvas.drawPath(
      needlePath,
      Paint()
        ..color = green
        ..style = PaintingStyle.fill,
    );
    // Center circle outer
    canvas.drawCircle(
      Offset(cx, cy),
      18,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(
            center: Offset(cx, cy),
            radius: 18,
          ),
        ),
      Colors.black26,
      4,
      true,
    );
    // Center circle inner
    canvas.drawCircle(
      Offset(cx, cy),
      16,
      Paint()
        ..color = green
        ..style = PaintingStyle.fill,
    );
  }

  void _drawKaabaAsset(
    Canvas canvas,
    Offset center,
  ) {
    if (kaabaImage == null) return;
    const double size = 42;
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
  bool shouldRepaint(
    covariant _CompassPainter oldDelegate,
  ) {
    return oldDelegate.heading != heading ||
        oldDelegate.qiblaDirection != qiblaDirection ||
        oldDelegate.kaabaImage != kaabaImage ||
        oldDelegate.languageCode != languageCode ||
        oldDelegate.compassColor != compassColor ||
        oldDelegate.labelColor != labelColor;
  }
} //
