import '/backend/schema/structs/index.dart';
import '/extra/lsinstllningar/lsinstllningar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'adhkar_header_model.dart';
export 'adhkar_header_model.dart';

class AdhkarHeaderWidget extends StatefulWidget {
  const AdhkarHeaderWidget({
    super.key,
    required this.pageName,
    required this.heptic,
    this.textSize,
    this.audio,
    this.initialValue,
    this.fontType,
  });

  final String? pageName;
  final bool? heptic;
  final bool? textSize;
  final bool? audio;
  final FontSettingStruct? initialValue;
  final String? fontType;

  @override
  State<AdhkarHeaderWidget> createState() => _AdhkarHeaderWidgetState();
}

class _AdhkarHeaderWidgetState extends State<AdhkarHeaderWidget> {
  late AdhkarHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdhkarHeaderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              valueOrDefault<String>(
                widget.pageName,
                'Name',
              ),
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    font: GoogleFonts.plusJakartaSans(
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
          ].divide(SizedBox(width: 20.0)),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (widget.audio ?? true)
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().updateAdhkarSettingStruct(
                    (e) => e..audioDisplay = !e.audioDisplay,
                  );
                  FFAppState().update(() {});
                },
                child: Icon(
                  Icons.volume_up,
                  color: FFAppState().adhkarSetting.audioDisplay
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            if (widget.heptic ?? true)
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().haptic = !(FFAppState().haptic ?? true);
                  safeSetState(() {});
                },
                child: Icon(
                  Icons.vibration_rounded,
                  color: FFAppState().haptic
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            if (widget.textSize ?? true)
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return WebViewAware(
                        child: Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: LsinstllningarWidget(
                            initialValue: widget.initialValue!,
                            value: widget.fontType!,
                          ),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                child: Icon(
                  Icons.settings_outlined,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
          ].divide(SizedBox(width: 15.0)),
        ),
      ],
    );
  }
}
