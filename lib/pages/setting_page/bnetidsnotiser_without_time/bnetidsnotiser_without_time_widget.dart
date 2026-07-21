import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bnetidsnotiser_without_time_model.dart';
export 'bnetidsnotiser_without_time_model.dart';

class BnetidsnotiserWithoutTimeWidget extends StatefulWidget {
  const BnetidsnotiserWithoutTimeWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.notice,
    required this.adhan,
  });

  final String? label;
  final Widget? icon;
  final bool? notice;
  final bool? adhan;

  @override
  State<BnetidsnotiserWithoutTimeWidget> createState() =>
      _BnetidsnotiserWithoutTimeWidgetState();
}

class _BnetidsnotiserWithoutTimeWidgetState
    extends State<BnetidsnotiserWithoutTimeWidget> {
  late BnetidsnotiserWithoutTimeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BnetidsnotiserWithoutTimeModel());

    _model.notisValue = widget.notice!;
    _model.adhanValue = widget.adhan!;
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 44.0,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .sm),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: widget.icon!,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      valueOrDefault<String>(
                                        widget.label,
                                        'add label',
                                      ),
                                      minFontSize:
                                          FFAppConstants.heading.toDouble(),
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.plusJakartaSans(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 5.0)),
                                ),
                              ].divide(SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Transform.scale(
                                  scaleX: 0.6,
                                  scaleY: 0.6,
                                  child: Switch.adaptive(
                                    value: _model.notisValue!,
                                    onChanged: (newValue) async {
                                      safeSetState(
                                          () => _model.notisValue = newValue);
                                    },
                                    activeColor: FlutterFlowTheme.of(context)
                                        .switchColor,
                                    activeTrackColor:
                                        FlutterFlowTheme.of(context).primary,
                                    inactiveTrackColor:
                                        FlutterFlowTheme.of(context)
                                            .switchColor,
                                    inactiveThumbColor: Colors.white,
                                  ),
                                ),
                                Transform.scale(
                                  scaleX: 0.6,
                                  scaleY: 0.6,
                                  child: Switch.adaptive(
                                    value: _model.adhanValue!,
                                    onChanged: (newValue) async {
                                      safeSetState(
                                          () => _model.adhanValue = newValue);
                                    },
                                    activeColor: FlutterFlowTheme.of(context)
                                        .switchColor,
                                    activeTrackColor:
                                        FlutterFlowTheme.of(context).primary,
                                    inactiveTrackColor:
                                        FlutterFlowTheme.of(context)
                                            .switchColor,
                                    inactiveThumbColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
