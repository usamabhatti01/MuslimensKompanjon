import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adhkar_all_pages_banner_model.dart';
export 'adhkar_all_pages_banner_model.dart';

class AdhkarAllPagesBannerWidget extends StatefulWidget {
  const AdhkarAllPagesBannerWidget({
    super.key,
    required this.pageName,
  });

  final String? pageName;

  @override
  State<AdhkarAllPagesBannerWidget> createState() =>
      _AdhkarAllPagesBannerWidgetState();
}

class _AdhkarAllPagesBannerWidgetState
    extends State<AdhkarAllPagesBannerWidget> {
  late AdhkarAllPagesBannerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdhkarAllPagesBannerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).tint,
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.md),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            FlutterFlowTheme.of(context).designToken.radius.lg,
            0.0,
            FlutterFlowTheme.of(context).designToken.spacing.lg,
            0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.pageName!,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleMedium.fontStyle,
                  ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/quran_1.png',
                width: 135.0,
                height: 86.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
