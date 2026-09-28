import '/backend/schema/enums/enums.dart';
import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tashbih_counter_model.dart';
export 'tashbih_counter_model.dart';

class TashbihCounterWidget extends StatefulWidget {
  const TashbihCounterWidget({
    super.key,
    required this.language,
    required this.index,
  });

  final String? language;
  final int? index;

  static String routeName = 'TashbihCounter';
  static String routePath = '/tashbihCounter';

  @override
  State<TashbihCounterWidget> createState() => _TashbihCounterWidgetState();
}

class _TashbihCounterWidgetState extends State<TashbihCounterWidget> {
  late TashbihCounterModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TashbihCounterModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.pageIndex = widget.index!;
      _model.counter = FFAppState()
          .tasbihList
          .elementAtOrNull(_model.pageIndex)!
          .targetCount;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
            padding: EdgeInsetsDirectional.fromSTEB(
                FlutterFlowTheme.of(context).designToken.spacing.md,
                FlutterFlowTheme.of(context).designToken.spacing.sm,
                FlutterFlowTheme.of(context).designToken.spacing.md,
                0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          TasbihWidget.routeName,
                          queryParameters: {
                            'adkar': serializeParam(
                              'Tasbih',
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: FFAppConstants.iconSize.toDouble(),
                      ),
                    ),
                    Expanded(
                      child: wrapWithModel(
                        model: _model.adhkarHeaderModel,
                        updateCallback: () => safeSetState(() {}),
                        child: AdhkarHeaderWidget(
                          pageName: 'Tasbih',
                          heptic: true,
                          textSize: true,
                          audio: false,
                          fontType: Font.tasbih.name,
                          initialValue: FFAppState().tasbihSetting,
                        ),
                      ),
                    ),
                  ].divide(SizedBox(
                      width:
                          FlutterFlowTheme.of(context).designToken.spacing.sm)),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .radius
                                  .sm),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .md),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (FFAppState().tasbihSetting.arActive)
                                AutoSizeText(
                                  valueOrDefault<String>(
                                    FFAppState()
                                        .tasbihList
                                        .elementAtOrNull(_model.pageIndex)
                                        ?.arabic,
                                    'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                                  ),
                                  textAlign: TextAlign.end,
                                  minFontSize:
                                      FFAppConstants.heading.toDouble(),
                                  style: FlutterFlowTheme.of(context)
                                      .arabiTitle
                                      .override(
                                        font: GoogleFonts.scheherazadeNew(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .arabiTitle
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .arabiTitle
                                            .fontStyle,
                                      ),
                                ),
                              if (FFAppState().tasbihSetting.enActive)
                                AutoSizeText(
                                  valueOrDefault<String>(
                                    FFAppState()
                                        .tasbihList
                                        .elementAtOrNull(_model.pageIndex)
                                        ?.transliteration,
                                    '0',
                                  ),
                                  textAlign: TextAlign.center,
                                  minFontSize:
                                      FFAppConstants.heading.toDouble(),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        fontSize:
                                            FFAppState().tasbihSetting.enFont,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                        lineHeight: 1.5,
                                      ),
                                ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.counter = _model.counter + -1;
                                  safeSetState(() {});
                                  await actions.triggerHapticFeedback();
                                  HapticFeedback.heavyImpact();
                                  if (_model.counter < 0) {
                                    if (_model.pageIndex <
                                        (FFAppState().tasbihList.length - 1)) {
                                      _model.pageIndex = _model.pageIndex + 1;
                                      _model.counter = FFAppState()
                                          .tasbihList
                                          .elementAtOrNull(_model.pageIndex)!
                                          .targetCount;
                                      safeSetState(() {});
                                    } else {
                                      _model.pageIndex = 0;
                                      _model.counter = FFAppState()
                                          .tasbihList
                                          .elementAtOrNull(_model.pageIndex)!
                                          .targetCount;
                                      safeSetState(() {});
                                    }
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 176.0,
                                      height: 176.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF25A55D),
                                          width: 4.8,
                                        ),
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: AutoSizeText(
                                          _model.counter.toString(),
                                          minFontSize:
                                              FFAppConstants.heading.toDouble(),
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .displaySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .displaySmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    if (FFAppState().tasbihSetting.swActive)
                                      AutoSizeText(
                                        valueOrDefault<String>(
                                          FFAppState()
                                              .tasbihList
                                              .elementAtOrNull(_model.pageIndex)
                                              ?.swedish,
                                          '0',
                                        ),
                                        textAlign: TextAlign.center,
                                        minFontSize:
                                            FFAppConstants.body.toDouble(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: FFAppState()
                                                  .tasbihSetting
                                                  .swFont,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                              lineHeight: 1.5,
                                            ),
                                      ),
                                  ].divide(SizedBox(height: 20.0)),
                                ),
                              ),
                            ].divide(SizedBox(height: 10.0)),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .radius
                                  .sm),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .md),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await actions.triggerHapticFeedback();
                                    _model.counter = FFAppState()
                                        .tasbihList
                                        .elementAtOrNull(widget.index!)!
                                        .targetCount;
                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    height: 90.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Nollställ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.w800,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _model.pageIndex = _model.pageIndex +
                                        (_model.pageIndex <
                                                (FFAppState()
                                                        .tasbihList
                                                        .length -
                                                    1)
                                            ? 1
                                            : functions.returnValue(FFAppState()
                                                .tasbihList
                                                .length));
                                    safeSetState(() {});
                                    _model.counter = FFAppState()
                                        .tasbihList
                                        .elementAtOrNull(_model.pageIndex)!
                                        .targetCount;
                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    height: 90.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Nästa Tasbih',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .white,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 10.0)),
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 20.0))
                        .addToStart(SizedBox(height: 10.0)),
                  ),
                ),
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
