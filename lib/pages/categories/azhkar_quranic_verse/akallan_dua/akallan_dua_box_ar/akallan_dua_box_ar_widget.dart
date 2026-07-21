import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'akallan_dua_box_ar_model.dart';
export 'akallan_dua_box_ar_model.dart';

class AkallanDuaBoxArWidget extends StatefulWidget {
  const AkallanDuaBoxArWidget({
    super.key,
    required this.tasbihName,
    required this.tasbih,
  });

  final String? tasbihName;
  final String? tasbih;

  @override
  State<AkallanDuaBoxArWidget> createState() => _AkallanDuaBoxArWidgetState();
}

class _AkallanDuaBoxArWidgetState extends State<AkallanDuaBoxArWidget> {
  late AkallanDuaBoxArModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AkallanDuaBoxArModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.md),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            FlutterFlowTheme.of(context).designToken.spacing.md,
            FlutterFlowTheme.of(context).designToken.spacing.sm,
            FlutterFlowTheme.of(context).designToken.spacing.md,
            FlutterFlowTheme.of(context).designToken.spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AutoSizeText(
              widget.tasbihName!,
              textAlign: TextAlign.end,
              minFontSize: FFAppConstants.body.toDouble(),
              style: FlutterFlowTheme.of(context).arabiTitle.override(
                    fontFamily: 'arabic',
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AutoSizeText(
              widget.tasbih!,
              textAlign: TextAlign.end,
              minFontSize: FFAppConstants.body.toDouble(),
              style: FlutterFlowTheme.of(context).arabicBody.override(
                    fontFamily: 'arabic',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    lineHeight: 2.0,
                  ),
            ),
          ].divide(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
