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

  ui.Image? _kaabaImage;

  late AnimationController _controller;
  late Animation<double> _animation;

  StreamSubscription<CompassEvent>? _compassSubscription;

  String _instruction = 'Fetching location...';

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
        _instruction = 'Location services disabled';
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
        _instruction = 'Location permission denied';
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

  void _startCompass() {
    final stream = FlutterCompass.events;

    if (stream == null) return;

    _compassSubscription = stream.listen((CompassEvent event) {
      final heading = event.heading;

      if (heading == null) return;

      final normalized = (heading % 360 + 360) % 360;

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

  String get directionInstruction {
    if (_heading == null || _qiblaDirection == null) {
      return _instruction;
    }

    double diff = ((_qiblaDirection! - _heading!) + 540) % 360 - 180;

    final absDiff = diff.abs();

    _isAligned = absDiff <= 2;

    // vibration feedback

    if (_isAligned && !_hasVibrated) {
      _hasVibrated = true;

      Vibration.vibrate(
        duration: 120,
      );
    }

    if (!_isAligned) {
      _hasVibrated = false;
    }

    if (_isAligned) {
      return 'Perfect alignment with Qibla';
    }

    final rounded = absDiff.round();

    if (diff > 0) {
      return 'Rotate the phone ${rounded}° to the right';
    } else {
      return 'Rotate the phone ${rounded}° to the left';
    }
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = math.min(
      widget.width ?? 350,
      widget.height ?? 600,
    );

    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size * 0.8,
            height: size * 0.8,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _CompassPainter(
                    heading: _animation.value,
                    qiblaDirection: _qiblaDirection ?? 0,
                    kaabaImage: _kaabaImage,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 34),
          Text(
            '${(_heading ?? 0).round()}°',
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w700,
              color: _isAligned
                  ? const Color(0xFFFFC107)
                  : const Color(0xFF0B7A12),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _isAligned ? 'Aligned with Qibla' : 'Device angle to qibla',
            style: TextStyle(
              fontSize: 16,
              color: _isAligned ? const Color(0xFFFFC107) : Colors.black87,
            ),
          ),
          const SizedBox(height: 28),
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 250,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: _isAligned
                  ? const Color(0xFFFFF8E1)
                  : const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(
                18,
              ),
              boxShadow: _isAligned
                  ? [
                      BoxShadow(
                        color: const Color(
                          0xFFFFC107,
                        ).withOpacity(
                          0.35,
                        ),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Text(
              directionInstruction,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: _isAligned ? FontWeight.w600 : FontWeight.w400,
                color: _isAligned ? const Color(0xFFFF8F00) : Colors.black87,
              ),
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

  _CompassPainter({
    required this.heading,
    required this.qiblaDirection,
    required this.kaabaImage,
  });

  static const green = Color(0xFF0B7A12);

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    final radius = size.width / 2 - 20;

    double alignmentDiff = ((qiblaDirection - heading) + 540) % 360 - 180;

    bool aligned = alignmentDiff.abs() <= 2;

    // glowing halo

    if (aligned) {
      final glowPaint = Paint()
        ..color = const Color(
          0xFFFFD54F,
        ).withOpacity(0.35)
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          30,
        );

      canvas.drawCircle(
        Offset(cx, cy),
        radius + 8,
        glowPaint,
      );
    }

    // outer circle

    final circlePaint = Paint()
      ..color = aligned ? const Color(0xFFFFC107) : green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      circlePaint,
    );

    // dots

    final dotPaint = Paint()
      ..color = aligned ? const Color(0xFFFFC107) : green
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

    // rotate letters

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
            color: aligned ? const Color(0xFFFFC107) : Colors.black87,
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

    // kaaba asset

    _drawKaabaAsset(
      canvas,
      Offset(
        cx,
        cy - radius + 8,
      ),
    );

    // top indicator

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
      Paint()..color = aligned ? const Color(0xFFFFC107) : green,
    );

    // needle snap logic

    double diff = ((qiblaDirection - heading) + 540) % 360 - 180;

    // auto snap

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
        ..color = aligned ? const Color(0xFFFFC107) : green
        ..style = PaintingStyle.fill,
    );

    // center circle outer

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

    // center circle inner

    canvas.drawCircle(
      Offset(cx, cy),
      16,
      Paint()
        ..color = aligned ? const Color(0xFFFFC107) : green
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
        oldDelegate.kaabaImage != kaabaImage;
  }
}
