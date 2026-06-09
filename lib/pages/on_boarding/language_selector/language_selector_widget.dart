import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'language_selector_model.dart';
export 'language_selector_model.dart';

class LanguageSelectorWidget extends StatefulWidget {
  const LanguageSelectorWidget({
    super.key,
    required this.shortName,
    required this.mainHeading,
    required this.detail,
    required this.select,
  });

  final String? shortName;
  final String? mainHeading;
  final String? detail;
  final bool? select;

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  late LanguageSelectorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LanguageSelectorModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.shortName,
                      'SV',
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget.mainHeading,
                      '.',
                    ),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget.detail,
                      '.',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
            ].divide(SizedBox(width: 20.0)),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              FlutterFlowRadioButton(
                options: [''].toList(),
                onChanged: (val) async {
                  safeSetState(() {});
                  if (widget.shortName == 'SV') {
                    FFAppState().updateUserStruct(
                      (e) => e..phoneDetect = true,
                    );
                    safeSetState(() {});
                    FFAppState().updateUserStruct(
                      (e) => e..switchToEnglish = false,
                    );
                    safeSetState(() {});
                  } else {
                    FFAppState().updateUserStruct(
                      (e) => e..phoneDetect = false,
                    );
                    safeSetState(() {});
                    FFAppState().updateUserStruct(
                      (e) => e..switchToEnglish = true,
                    );
                    safeSetState(() {});
                  }

                  safeSetState(() {});
                },
                controller: _model.radioButtonValueController ??=
                    FormFieldController<String>(null),
                optionHeight: 32.0,
                textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                selectedTextStyle: FlutterFlowTheme.of(context)
                    .bodyMedium
                    .override(
                      font: GoogleFonts.manrope(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                buttonPosition: RadioButtonPosition.left,
                direction: Axis.vertical,
                radioButtonColor: FlutterFlowTheme.of(context).primary,
                inactiveRadioButtonColor:
                    FlutterFlowTheme.of(context).secondaryText,
                toggleable: true,
                horizontalAlignment: WrapAlignment.start,
                verticalAlignment: WrapCrossAlignment.start,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
