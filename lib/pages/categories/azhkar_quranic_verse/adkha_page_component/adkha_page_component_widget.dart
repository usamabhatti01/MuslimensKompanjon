import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adkha_page_component_model.dart';
export 'adkha_page_component_model.dart';

class AdkhaPageComponentWidget extends StatefulWidget {
  const AdkhaPageComponentWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final Widget? icon;
  final String? title;

  @override
  State<AdkhaPageComponentWidget> createState() =>
      _AdkhaPageComponentWidgetState();
}

class _AdkhaPageComponentWidgetState extends State<AdkhaPageComponentWidget> {
  late AdkhaPageComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdkhaPageComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 121.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.sm),
        border: Border.all(
          color: FlutterFlowTheme.of(context).containerBg,
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.icon!,
            Text(
              valueOrDefault<String>(
                widget.title,
                'Add Title',
              ),
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  ),
            ),
          ].divide(SizedBox(width: 20.0)),
        ),
      ),
    );
  }
}
