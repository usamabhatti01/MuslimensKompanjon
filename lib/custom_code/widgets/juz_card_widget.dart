// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class JuzCardWidget extends StatefulWidget {
  const JuzCardWidget({
    super.key,
    this.width,
    this.height,
    this.juzNumber,
    this.juzNumberText,
    this.juzName,
    this.totalVerses,
  });

  final double? width;
  final double? height;
  final int? juzNumber;
  final String? juzNumberText;
  final String? juzName;
  final String? totalVerses;

  @override
  State<JuzCardWidget> createState() => _JuzCardWidgetState();
}

class _JuzCardWidgetState extends State<JuzCardWidget> {
  @override
  Widget build(BuildContext context) {
    // Colors derived automatically from theme
    final theme = FlutterFlowTheme.of(context);
    final baseColor = theme.primary;
    const gold = Color(0xFFD4AF37);
    const lightGold = Color(0xFFFBE89B);
    const darkGold = Color(0xFF9E721D);

    // Compute rich multi-stop gradient based on theme primary color
    final hsl = HSLColor.fromColor(baseColor);
    final edgeColor = hsl
        .withLightness((hsl.lightness * 0.28).clamp(0.04, 0.12))
        .withSaturation((hsl.saturation * 0.85).clamp(0.3, 0.95))
        .toColor();
    final centerColor = hsl
        .withLightness((hsl.lightness * 0.60).clamp(0.12, 0.24))
        .withSaturation((hsl.saturation * 0.95).clamp(0.4, 0.98))
        .toColor();

    final cardHeight = widget.height ?? 115.0;
    final displayJuzNumber = widget.juzNumberText ??
        (widget.juzNumber != null ? widget.juzNumber.toString() : '1');
    final displayJuzName = widget.juzName ?? 'الم';

    String displayVerses;
    if (widget.totalVerses == null || widget.totalVerses!.isEmpty) {
      displayVerses = 'الجزء الأول - آية ١٤٨';
    } else {
      final tv = widget.totalVerses!.trim();
      if (tv.contains('آية') ||
          tv.contains('الجزء') ||
          tv.toLowerCase().contains('vers')) {
        displayVerses = tv;
      } else {
        displayVerses = 'الجزء $displayJuzNumber - آية $tv';
      }
    }

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: cardHeight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 12.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Layer 1: Dark themed luxury radial gradient background
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.0, -0.15),
                    radius: 1.35,
                    colors: [
                      centerColor,
                      edgeColor,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),

              // Layer 2: Subtle textured ornate frame & corner arabesques
              CustomPaint(
                painter: _IslamicFramePainter(
                  goldColor: gold,
                  lightGold: lightGold,
                  darkGold: darkGold,
                ),
              ),

              // Layer 3: Content Row
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Ornament: 16-point Islamic Rosette Medallion with Juz Number
                    SizedBox(
                      width: 68.0,
                      height: 68.0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(68.0, 68.0),
                            painter: _IslamicRosettePainter(
                              goldColor: gold,
                              lightGold: lightGold,
                              darkGold: darkGold,
                              innerBgColor: edgeColor,
                            ),
                          ),
                          // Juz Number text inside medallion
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  lightGold,
                                  Color(0xFFD4AF37),
                                  lightGold,
                                ],
                              ).createShader(bounds),
                              child: Text(
                                displayJuzNumber,
                                style: GoogleFonts.scheherazadeNew(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                  shadows: [
                                    Shadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.6),
                                      offset: const Offset(1, 1),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Center: Calligraphy Juz Name & Verses Subtitle
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Juz Name / Arabic Calligraphy Title
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFFF4C2),
                                  gold,
                                  Color(0xFFC79A2B),
                                ],
                              ).createShader(bounds),
                              child: Text(
                                displayJuzName,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'arabic',
                                  color: Colors.white,
                                  fontSize: 34.0,
                                  fontWeight: FontWeight.w700,
                                  height: 1.15,
                                  shadows: [
                                    Shadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.7),
                                      offset: const Offset(0, 2),
                                      blurRadius: 4,
                                    ),
                                    Shadow(
                                      color: gold.withValues(alpha: 0.35),
                                      offset: const Offset(0, 0),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            // Verses text / Subtitle
                            Text(
                              displayVerses,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'arabic',
                                color: lightGold.withValues(alpha: 0.95),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withValues(alpha: 0.6),
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Right Ornament: 8-Pointed Islamic Faceted Star
                    SizedBox(
                      width: 48.0,
                      height: 48.0,
                      child: CustomPaint(
                        size: const Size(48.0, 48.0),
                        painter: _IslamicFacetedStarPainter(
                          goldColor: gold,
                          lightGold: lightGold,
                          darkGold: darkGold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// Custom Painters for the Gold Ornaments, Corners, and Medallions
// -------------------------------------------------------------

class _IslamicFramePainter extends CustomPainter {
  final Color goldColor;
  final Color lightGold;
  final Color darkGold;

  _IslamicFramePainter({
    required this.goldColor,
    required this.lightGold,
    required this.darkGold,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 1. Outer Frame with Gold Gradient
    final outerRRect = RRect.fromRectAndRadius(
      rect.deflate(2.0),
      const Radius.circular(14.0),
    );
    final outerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          lightGold,
          goldColor,
          darkGold,
          lightGold,
          goldColor,
        ],
      ).createShader(rect);
    canvas.drawRRect(outerRRect, outerPaint);

    // 2. Inner Inset Frame
    final innerRRect = RRect.fromRectAndRadius(
      rect.deflate(6.0),
      const Radius.circular(10.0),
    );
    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = goldColor.withValues(alpha: 0.65);
    canvas.drawRRect(innerRRect, innerPaint);

    // 3. Ornate Corner Arabesques in 4 Corners
    _drawCornerFlourish(canvas, size, isTop: true, isLeft: true);
    _drawCornerFlourish(canvas, size, isTop: true, isLeft: false);
    _drawCornerFlourish(canvas, size, isTop: false, isLeft: true);
    _drawCornerFlourish(canvas, size, isTop: false, isLeft: false);
  }

  void _drawCornerFlourish(
    Canvas canvas,
    Size size, {
    required bool isTop,
    required bool isLeft,
  }) {
    canvas.save();

    final tx = isLeft ? 6.0 : size.width - 6.0;
    final ty = isTop ? 6.0 : size.height - 6.0;
    canvas.translate(tx, ty);
    canvas.scale(isLeft ? 1.0 : -1.0, isTop ? 1.0 : -1.0);

    final flourishPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..color = lightGold.withValues(alpha: 0.85);

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = goldColor.withValues(alpha: 0.7);

    // Inner corner scroll bracket
    final path = Path();
    path.moveTo(0, 22);
    path.cubicTo(6, 18, 14, 14, 18, 6);
    path.cubicTo(20, 2, 22, 0, 24, 0);
    canvas.drawPath(path, flourishPaint);

    // Delicate corner loop / leaf
    final loop = Path();
    loop.moveTo(4, 4);
    loop.cubicTo(12, 4, 14, 12, 12, 14);
    loop.cubicTo(8, 16, 4, 10, 4, 4);
    canvas.drawPath(loop, flourishPaint);

    // Micro flower dot
    canvas.drawCircle(const Offset(6, 6), 1.6, fillPaint);
    canvas.drawCircle(const Offset(18, 3), 1.2, fillPaint);
    canvas.drawCircle(const Offset(3, 18), 1.2, fillPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _IslamicFramePainter oldDelegate) =>
      oldDelegate.goldColor != goldColor ||
      oldDelegate.lightGold != lightGold ||
      oldDelegate.darkGold != darkGold;
}

/// Left Rosette: Interlaced 16-pointed lobed Islamic medallion
class _IslamicRosettePainter extends CustomPainter {
  final Color goldColor;
  final Color lightGold;
  final Color darkGold;
  final Color innerBgColor;

  _IslamicRosettePainter({
    required this.goldColor,
    required this.lightGold,
    required this.darkGold,
    required this.innerBgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final outerPath = _createStarPolygon(center, 16, radius - 2, radius - 7);
    final innerPath = _createStarPolygon(center, 16, radius - 6, radius - 11);

    // Outer Ribbon with Gold Gradient
    final ribbonPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..shader = SweepGradient(
        colors: [
          lightGold,
          goldColor,
          darkGold,
          lightGold,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawPath(outerPath, ribbonPaint);

    // Secondary inner star ribbon
    final innerRibbonPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = lightGold.withValues(alpha: 0.9);
    canvas.drawPath(innerPath, innerRibbonPaint);

    // Core circular disc filled with deep theme color
    final corePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = innerBgColor;
    canvas.drawCircle(center, radius - 14, corePaint);

    // Core gold inner ring
    final coreRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = goldColor;
    canvas.drawCircle(center, radius - 14, coreRing);
  }

  Path _createStarPolygon(
      Offset center, int points, double rOuter, double rInner) {
    final path = Path();
    final step = math.pi / points;

    for (int i = 0; i < 2 * points; i++) {
      final r = (i % 2 == 0) ? rOuter : rInner;
      final angle = i * step - (math.pi / 2);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _IslamicRosettePainter oldDelegate) => true;
}

/// Right Emblem: 8-Pointed Faceted 3D Gold Star
class _IslamicFacetedStarPainter extends CustomPainter {
  final Color goldColor;
  final Color lightGold;
  final Color darkGold;

  _IslamicFacetedStarPainter({
    required this.goldColor,
    required this.lightGold,
    required this.darkGold,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rOuter = size.width / 2 - 2;
    final rInner = rOuter * 0.42;

    const points = 8;
    const step = math.pi / 4; // 45 degrees per point

    final lightFacetPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = lightGold;

    final midFacetPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = goldColor;

    final darkFacetPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = darkGold;

    // Draw the 16 faceted triangles for 3D metallic effect
    for (int i = 0; i < points; i++) {
      final tipAngle = i * step - (math.pi / 2);
      final prevValleyAngle = tipAngle - (step / 2);
      final nextValleyAngle = tipAngle + (step / 2);

      final tip = Offset(
        center.dx + rOuter * math.cos(tipAngle),
        center.dy + rOuter * math.sin(tipAngle),
      );
      final prevValley = Offset(
        center.dx + rInner * math.cos(prevValleyAngle),
        center.dy + rInner * math.sin(prevValleyAngle),
      );
      final nextValley = Offset(
        center.dx + rInner * math.cos(nextValleyAngle),
        center.dy + rInner * math.sin(nextValleyAngle),
      );

      // Left facet (illuminated)
      final leftFacet = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(prevValley.dx, prevValley.dy)
        ..lineTo(tip.dx, tip.dy)
        ..close();
      canvas.drawPath(
          leftFacet, (i % 2 == 0) ? lightFacetPaint : midFacetPaint);

      // Right facet (shadowed)
      final rightFacet = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(tip.dx, tip.dy)
        ..lineTo(nextValley.dx, nextValley.dy)
        ..close();
      canvas.drawPath(rightFacet, darkFacetPaint);
    }

    // Outer edge stroke
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = lightGold.withValues(alpha: 0.8);

    final fullStarPath = Path();
    for (int i = 0; i < 16; i++) {
      final r = (i % 2 == 0) ? rOuter : rInner;
      final angle = i * (math.pi / 8) - (math.pi / 2);
      final pt = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );
      if (i == 0) {
        fullStarPath.moveTo(pt.dx, pt.dy);
      } else {
        fullStarPath.lineTo(pt.dx, pt.dy);
      }
    }
    fullStarPath.close();
    canvas.drawPath(fullStarPath, strokePaint);

    // Center faceted diamond / jewel rosette
    final hubPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = lightGold;
    canvas.drawCircle(center, 4.0, hubPaint);

    final hubRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = darkGold;
    canvas.drawCircle(center, 4.0, hubRing);
  }

  @override
  bool shouldRepaint(covariant _IslamicFacetedStarPainter oldDelegate) => true;
}
