import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'adkhar_box_model.dart';
export 'adkhar_box_model.dart';

class AdkharBoxWidget extends StatefulWidget {
  const AdkharBoxWidget({
    super.key,
    required this.azkarNumber,
    required this.azkarNmae,
    required this.azkar,
  });

  final int? azkarNumber;
  final String? azkarNmae;
  final String? azkar;

  @override
  State<AdkharBoxWidget> createState() => _AdkharBoxWidgetState();
}

class _AdkharBoxWidgetState extends State<AdkharBoxWidget> {
  late AdkharBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdkharBoxModel());
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
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 38.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(
                  FlutterFlowTheme.of(context).designToken.radius.md),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  FlutterFlowTheme.of(context).designToken.spacing.md,
                  FlutterFlowTheme.of(context).designToken.spacing.xs,
                  FlutterFlowTheme.of(context).designToken.spacing.md,
                  FlutterFlowTheme.of(context).designToken.spacing.xs),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Adkhar ${widget.azkarNumber?.toString()}',
                    style: FlutterFlowTheme.of(context).arabicBody.override(
                          fontFamily: 'arabic',
                          color: FlutterFlowTheme.of(context).black,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Text(
                    widget.azkarNmae!,
                    style: FlutterFlowTheme.of(context).arabiTitle.override(
                          fontFamily: 'arabic',
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            widget.azkar!,
            textAlign: TextAlign.end,
            style: FlutterFlowTheme.of(context).arabicBody.override(
                  fontFamily: 'arabic',
                  color: FlutterFlowTheme.of(context).black,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ].divide(SizedBox(height: 15.0)).addToEnd(SizedBox(height: 15.0)),
      ),
    );
  }
}
