import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/on_boarding/language_selector/language_selector_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'on_boarding00_model.dart';
export 'on_boarding00_model.dart';

class OnBoarding00Widget extends StatefulWidget {
  const OnBoarding00Widget({super.key});

  static String routeName = 'OnBoarding_00';
  static String routePath = '/onBoarding00';

  @override
  State<OnBoarding00Widget> createState() => _OnBoarding00WidgetState();
}

class _OnBoarding00WidgetState extends State<OnBoarding00Widget> {
  late OnBoarding00Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnBoarding00Model());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(
                FlutterFlowTheme.of(context).designToken.spacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose Language',
                  style: FlutterFlowTheme.of(context).headlineLarge.override(
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
                  'The app follows your phone\'s language automatically. You can change this later in settings.',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                wrapWithModel(
                  model: _model.languageSelectorModel1,
                  updateCallback: () => safeSetState(() {}),
                  child: LanguageSelectorWidget(
                    shortName: 'SV',
                    mainHeading: 'Svenska',
                    detail: 'Detected from your phone',
                    select: FFAppState().user.phoneDetect,
                  ),
                ),
                wrapWithModel(
                  model: _model.languageSelectorModel2,
                  updateCallback: () => safeSetState(() {}),
                  child: LanguageSelectorWidget(
                    shortName: 'EN',
                    mainHeading: 'English',
                    detail: 'Switch to English',
                    select: FFAppState().user.switchToEnglish,
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed(OnBoarding01Widget.routeName);
                  },
                  text: 'Continue',
                  icon: Icon(
                    Icons.east_rounded,
                    size: 18.0,
                  ),
                  options: FFButtonOptions(
                    width: 300.0,
                    height: 50.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconAlignment: IconAlignment.end,
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    iconColor: FlutterFlowTheme.of(context).primaryBackground,
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context)
                        .titleMedium
                        .override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ].divide(SizedBox(height: 25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
