import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/on_boarding/language_selector/language_selector_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'select_language_model.dart';
export 'select_language_model.dart';

class SelectLanguageWidget extends StatefulWidget {
  const SelectLanguageWidget({super.key});

  @override
  State<SelectLanguageWidget> createState() => _SelectLanguageWidgetState();
}

class _SelectLanguageWidgetState extends State<SelectLanguageWidget> {
  late SelectLanguageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectLanguageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding:
            EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.sm),
        child: SafeArea(
          child: Container(
            height: 400.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                  FlutterFlowTheme.of(context).designToken.spacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'j592cc89' /* Välj språk */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineLarge
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '20n2l1zk' /* Choose language */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'b5evds53' /* Appen följer ditt telefonspråk... */,
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
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: wrapWithModel(
                          model: _model.svenskaModel,
                          updateCallback: () => safeSetState(() {}),
                          child: LanguageSelectorWidget(
                            shortName: 'SV',
                            mainHeading: 'Svenska',
                            detail: 'Detekterat från din telefon',
                            select: false,
                          ),
                        ),
                      ),
                      Container(
                        child: wrapWithModel(
                          model: _model.englishModel,
                          updateCallback: () => safeSetState(() {}),
                          child: LanguageSelectorWidget(
                            shortName: 'EN',
                            mainHeading: 'English',
                            detail: 'Switch to English',
                            select: false,
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(OnBoarding02Widget.routeName);
                    },
                    text: FFLocalizations.of(context).getText(
                      'kqunxrd7' /* Fortsätt */,
                    ),
                    icon: Icon(
                      Icons.arrow_forward_outlined,
                      size: 16.0,
                    ),
                    options: FFButtonOptions(
                      width: 250.0,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconAlignment: IconAlignment.end,
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconColor: FlutterFlowTheme.of(context).primaryBackground,
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ].divide(SizedBox(height: 20.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
