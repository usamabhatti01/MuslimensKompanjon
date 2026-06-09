import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'setting_tab_model.dart';
export 'setting_tab_model.dart';

class SettingTabWidget extends StatefulWidget {
  const SettingTabWidget({
    super.key,
    required this.label,
    required this.sunLabel,
    required this.icon,
  });

  final String? label;
  final String? sunLabel;
  final Widget? icon;

  @override
  State<SettingTabWidget> createState() => _SettingTabWidgetState();
}

class _SettingTabWidgetState extends State<SettingTabWidget> {
  late SettingTabModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingTabModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          FlutterFlowTheme.of(context).designToken.spacing.md,
          FlutterFlowTheme.of(context).designToken.spacing.sm,
          FlutterFlowTheme.of(context).designToken.spacing.md,
          FlutterFlowTheme.of(context).designToken.spacing.sm),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(
                        FlutterFlowTheme.of(context).designToken.radius.sm),
                  ),
                  child: widget.icon!,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.label,
                        'add label',
                      ),
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.manrope(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.sunLabel,
                        'add sublabel',
                      ),
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
              ].divide(SizedBox(width: 20.0)),
            ),
          ),
        ],
      ),
    );
  }
}
