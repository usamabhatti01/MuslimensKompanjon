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

class SurahHeaderWidget extends StatefulWidget {
  const SurahHeaderWidget({
    super.key,
    this.width,
    this.height,
    required this.text,
  });

  final double? width;
  final double? height;
  final String text;

  @override
  State<SurahHeaderWidget> createState() => _SurahHeaderWidgetState();
}

class _SurahHeaderWidgetState extends State<SurahHeaderWidget> {
  // Static Colors (Hardcoded to match your design)
  static const Color fontCol = Color(0xFF0F6317); // Green text
  static const Color borderCol = Color(0xFF0F6317); // Green border
  static const Color bgCol = Colors.white; // White background
  static const String family = 'Uthmanic Script'; // Arabic font family
  static const double size = 24.0; // Font size
  @override
  Widget build(BuildContext context) {
    final double widgetWidth = widget.width ?? 320.0;
    final double widgetHeight = widget.height ?? 60.0;
    final String displayText = widget.text ?? "سورة العنكبوت";
    TextStyle textStyle = const TextStyle(
      fontFamily: family,
      fontSize: size,
      color: fontCol,
      fontWeight: FontWeight.normal,
    );
    return Container(
      width: widgetWidth,
      height: widgetHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ornate vector borders
          Positioned.fill(
            child: CustomPaint(
              painter: _OrnateBorderPainter(
                borderColor: borderCol,
                backgroundColor: bgCol,
              ),
            ),
          ),
          // Centered Surah Text
          Padding(
            // Horizontal padding prevents text from overlapping the ornate ends
            padding: EdgeInsets.symmetric(horizontal: widgetHeight * 0.9),
            child: Center(
              child: Text(
                displayText,
                textAlign: TextAlign.center,
                style: textStyle,
                textDirection: ui.TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrnateBorderPainter extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;
  _OrnateBorderPainter({
    required this.borderColor,
    required this.backgroundColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final double W = size.width;
    final double H = size.height;
    // Coordinates for left and right decoration centers
    final double centerLeftX = H / 2;
    final double centerRightX = W - H / 2;
    final double centerY = H / 2;
    final Paint fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final Paint innerBorderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    // 1. Draw outer stadium shape (base white background fill)
    final RRect outerRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, W, H),
      Radius.circular(H / 2),
    );
    canvas.drawRRect(outerRRect, fillPaint);
    // 2. Draw outer boundary border
    canvas.drawRRect(outerRRect, borderPaint);
    // 3. Draw inner concentric stadium border (inset slightly)
    final double inset = 5.0;
    final RRect innerRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(inset, inset, W - 2 * inset, H - 2 * inset),
      Radius.circular((H - 2 * inset) / 2),
    );
    canvas.drawRRect(innerRRect, innerBorderPaint);
    // 4. Draw the ornate elements at the left and right center points
    final double diamondSize =
        H * 0.44; // Proportional sizing based on widget height
    void drawEndDecoration(double cx, double cy) {
      // Draw outer diamond background fill (covers overlapping lines) and border
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(3.141592653589793 / 4); // Rotate 45 degrees
      final Rect diamondRect = Rect.fromCenter(
        center: Offset.zero,
        width: diamondSize,
        height: diamondSize,
      );
      final RRect diamondRRect = RRect.fromRectAndRadius(
        diamondRect,
        const Radius.circular(5.0), // Rounded corners
      );
      // Mask whatever is underneath the diamond
      canvas.drawRRect(diamondRRect, fillPaint);
      canvas.drawRRect(diamondRRect, borderPaint);
      // Draw the solid green inside diamond
      final double solidSize = diamondSize * 0.55;
      final Paint solidPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.fill;

      final RRect solidRRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset.zero, width: solidSize, height: solidSize),
        const Radius.circular(2.0),
      );
      canvas.drawRRect(solidRRect, solidPaint);
      canvas.restore();
      // Draw the small white circle inside the solid green diamond
      final Paint centerCirclePaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(cx, cy), H * 0.08, centerCirclePaint);
    }

    // Paint the left and right decorations
    drawEndDecoration(centerLeftX, centerY);
    drawEndDecoration(centerRightX, centerY);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
