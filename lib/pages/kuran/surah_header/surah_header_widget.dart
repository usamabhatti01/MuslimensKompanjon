import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'surah_header_model.dart';
export 'surah_header_model.dart';

class SurahHeaderWidget extends StatefulWidget {
  const SurahHeaderWidget({
    super.key,
    required this.headerValue,
    this.width,
    this.height,
    required this.fontSize,
  });

  final String? headerValue;
  final double? width;
  final double? height;
  final int? fontSize;

  @override
  State<SurahHeaderWidget> createState() => _SurahHeaderWidgetState();
}

class _SurahHeaderWidgetState extends State<SurahHeaderWidget> {
  late SurahHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SurahHeaderModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: AlignmentDirectional(0.0, 0.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/textframe_1_(2).png',
              width: widget.width,
              height: widget.height,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            valueOrDefault<String>(
              widget.headerValue,
              'سُورَةُ الْعَنكَبُوتِ',
            ),
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w900,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  fontSize: widget.fontSize?.toDouble(),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w900,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
        ],
      ),
    );
  }
}
