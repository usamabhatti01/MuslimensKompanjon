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

import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

enum _NavIconType { home, koran, adhkar, qibla, mer }

class CustomPageFooter extends StatefulWidget {
  const CustomPageFooter({
    super.key,
    this.width,
    this.height,
    required this.selectedIndex,
  });

  final double? width;
  final double? height;
  final int selectedIndex;

  @override
  State<CustomPageFooter> createState() => _CustomPageFooterState();
}

class _CustomPageFooterState extends State<CustomPageFooter> {
  Widget _buildNavItem({
    required int index,
    required String label,
    required _NavIconType iconType,
    required String routePath,
    required String routeName,
  }) {
    final isSelected = widget.selectedIndex == index;
    final color = isSelected
        ? FlutterFlowTheme.of(context).primary
        : FlutterFlowTheme.of(context).footerInActive;

    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (getCurrentRoute(context) != routePath) {
            context.pushNamed(
              routeName,
              extra: <String, dynamic>{
                '__transition_info__': const TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24.0,
                height: 24.0,
                child: Center(
                  child: _NavBarIcon(
                    type: iconType,
                    color: color,
                    size: 22.0,
                    strokeWidth: isSelected ? 2.4 : 2.2,
                  ),
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                label,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.manrope(
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodySmall.fontStyle,
                      ),
                      color: color,
                      fontSize: 10.5,
                      letterSpacing: 0.0,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      padding: const EdgeInsets.only(top: 6.0, bottom: 4.0),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(
              index: 0,
              label: 'Hem',
              iconType: _NavIconType.home,
              routePath: '/home',
              routeName: 'Home',
            ),
            _buildNavItem(
              index: 1,
              label: 'Koran',
              iconType: _NavIconType.koran,
              routePath: '/kuranHome',
              routeName: 'kuranHome',
            ),
            _buildNavItem(
              index: 2,
              label: 'Adhkar',
              iconType: _NavIconType.adhkar,
              routePath: '/adhkar',
              routeName: 'Adhkar',
            ),
            _buildNavItem(
              index: 3,
              label: 'Qibla',
              iconType: _NavIconType.qibla,
              routePath: '/qiblaFinder',
              routeName: 'QiblaFinder',
            ),
            _buildNavItem(
              index: 4,
              label: 'Mer',
              iconType: _NavIconType.mer,
              routePath: '/setting',
              routeName: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  const _NavBarIcon({
    required this.type,
    required this.color,
    this.size = 22.0,
    this.strokeWidth = 2.2,
  });

  final _NavIconType type;
  final Color color;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _NavBarIconPainter(
        type: type,
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _NavBarIconPainter extends CustomPainter {
  _NavBarIconPainter({
    required this.type,
    required this.color,
    required this.strokeWidth,
  });

  final _NavIconType type;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    canvas.save();
    canvas.scale(scale, scale);

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    switch (type) {
      case _NavIconType.home:
        final roofPath = Path()
          ..moveTo(2.5, 11.5)
          ..lineTo(12.0, 3.5)
          ..lineTo(21.5, 11.5);
        canvas.drawPath(roofPath, strokePaint);

        final bodyPath = Path()
          ..moveTo(4.5, 10.5)
          ..lineTo(4.5, 19.5)
          ..arcToPoint(
            const Offset(6.0, 21.0),
            radius: const Radius.circular(1.5),
          )
          ..lineTo(9.0, 21.0)
          ..lineTo(9.0, 15.5)
          ..arcToPoint(
            const Offset(10.5, 14.0),
            radius: const Radius.circular(1.5),
          )
          ..lineTo(13.5, 14.0)
          ..arcToPoint(
            const Offset(15.0, 15.5),
            radius: const Radius.circular(1.5),
          )
          ..lineTo(15.0, 21.0)
          ..lineTo(18.0, 21.0)
          ..arcToPoint(
            const Offset(19.5, 19.5),
            radius: const Radius.circular(1.5),
          )
          ..lineTo(19.5, 10.5);
        canvas.drawPath(bodyPath, strokePaint);
        break;

      case _NavIconType.koran:
        final leftPage = Path()
          ..moveTo(12.0, 7.0)
          ..quadraticBezierTo(7.5, 5.0, 3.5, 5.8)
          ..lineTo(3.5, 17.8)
          ..quadraticBezierTo(7.5, 17.0, 12.0, 19.0)
          ..lineTo(12.0, 7.0);
        canvas.drawPath(leftPage, strokePaint);

        final rightPage = Path()
          ..moveTo(12.0, 7.0)
          ..quadraticBezierTo(16.5, 5.0, 20.5, 5.8)
          ..lineTo(20.5, 17.8)
          ..quadraticBezierTo(16.5, 17.0, 12.0, 19.0);
        canvas.drawPath(rightPage, strokePaint);
        break;

      case _NavIconType.adhkar:
        final moonPath = Path()
          ..moveTo(11.0, 3.8)
          ..cubicTo(4.0, 4.8, 1.5, 13.5, 6.8, 19.0)
          ..cubicTo(10.2, 22.2, 15.5, 21.0, 17.5, 18.0)
          ..cubicTo(10.5, 18.0, 7.5, 11.5, 11.0, 3.8)
          ..close();
        canvas.drawPath(moonPath, strokePaint);

        _drawStar(canvas, const Offset(15.5, 5.5), 1.8, strokePaint, fillPaint);
        _drawStar(canvas, const Offset(20.0, 7.5), 1.6, strokePaint, fillPaint);
        _drawStar(
            canvas, const Offset(18.5, 13.0), 1.4, strokePaint, fillPaint);
        break;

      case _NavIconType.qibla:
        canvas.drawCircle(const Offset(12.0, 12.0), 9.0, strokePaint);
        final needlePath = Path()
          ..moveTo(15.8, 8.2)
          ..lineTo(13.2, 13.2)
          ..lineTo(8.2, 15.8)
          ..lineTo(10.8, 10.8)
          ..close();
        canvas.drawPath(needlePath, strokePaint);
        break;

      case _NavIconType.mer:
        canvas.drawLine(
          const Offset(4.5, 7.0),
          const Offset(19.5, 7.0),
          strokePaint,
        );
        canvas.drawLine(
          const Offset(4.5, 12.0),
          const Offset(19.5, 12.0),
          strokePaint,
        );
        canvas.drawLine(
          const Offset(4.5, 17.0),
          const Offset(19.5, 17.0),
          strokePaint,
        );
        break;
    }

    canvas.restore();
  }

  void _drawStar(
    Canvas canvas,
    Offset center,
    double radius,
    Paint strokePaint,
    Paint fillPaint,
  ) {
    final path = Path();
    for (int i = 0; i < 4; i++) {
      final angle = (i * math.pi) / 2;
      final outerX = center.dx + radius * math.cos(angle);
      final outerY = center.dy + radius * math.sin(angle);
      final innerAngle = angle + math.pi / 4;
      final innerX = center.dx + (radius * 0.35) * math.cos(innerAngle);
      final innerY = center.dy + (radius * 0.35) * math.sin(innerAngle);

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      path.lineTo(innerX, innerY);
    }
    path.close();
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _NavBarIconPainter oldDelegate) {
    return oldDelegate.type != type ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
