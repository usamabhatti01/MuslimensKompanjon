import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tashbih_counter_model.dart';
export 'tashbih_counter_model.dart';

class TashbihCounterWidget extends StatefulWidget {
  const TashbihCounterWidget({super.key});

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                wrapWithModel(
                  model: _model.pageSubHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PageSubHeaderWidget(
                    pageName: 'Tasbih',
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 351.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .radius
                                  .sm),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).containerBg,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .md),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    FFAppState().tasbihList.firstWhere(
                                        (item) =>
                                            item['id'] ==
                                            FFAppState().currentTasbihId,
                                        orElse: () => {})['tasbihName'],
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .arabiFont
                                        .override(
                                          font: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .arabiFont
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontSize: 22.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .arabiFont
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    FFAppState().tasbihList.firstWhere(
                                        (item) =>
                                            item['id'] ==
                                            FFAppState().currentTasbihId,
                                        orElse: () => {})['englishDescription'],
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ],
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  FFAppState().counter =
                                      FFAppState().counter + 1;
                                  safeSetState(() {});
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
                                        child: Text(
                                          FFAppState().counter.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .counterFont
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .counterFont
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                fontSize: 50.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .counterFont
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Tap circle to count',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.manrope(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 20.0)),
                                ),
                              ),
                            ].divide(SizedBox(height: 20.0)),
                          ),
                        ),
                      ),
                      Container(
                        height: 110.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .radius
                                  .sm),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).containerBg,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .md),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .sm),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .containerBg,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      'Counts ${FFAppState().counter.toString()}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.manrope(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
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
                                    FFAppState().counter = 0;
                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .radius
                                              .sm),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .containerBg,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'Reset',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight: FontWeight.w800,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w800,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
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
                                    if (FFAppState().currentTasbihId >= 5) {
                                      FFAppState().currentTasbihId = 1;
                                      safeSetState(() {});
                                    } else {
                                      FFAppState().currentTasbihId =
                                          FFAppState().currentTasbihId + 1;
                                      safeSetState(() {});
                                    }

                                    FFAppState().sessionCount =
                                        FFAppState().sessionCount + 1;
                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .radius
                                              .sm),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .containerBg,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'Next Zikr',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight: FontWeight.w800,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w800,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 10.0)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .radius
                                    .sm),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).containerBg,
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
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .radius
                                                .sm),
                                        topRight: Radius.circular(
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .radius
                                                .sm),
                                      ),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .containerBg,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Daily Goal',
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
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: FFAppState()
                                                    .counter
                                                    .toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .arabiFont
                                                    .override(
                                                      font: GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .arabiFont
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 22.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .arabiFont
                                                              .fontStyle,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: '/',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .arabiFont
                                                    .override(
                                                      font: GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .arabiFont
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 22.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .arabiFont
                                                              .fontStyle,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: FFAppState()
                                                    .tasbihList
                                                    .firstWhere(
                                                        (item) =>
                                                            item['id'] ==
                                                            FFAppState()
                                                                .currentTasbihId,
                                                        orElse: () =>
                                                            {})['limit']
                                                    .toString(),
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .arabiFont
                                                .override(
                                                  font: GoogleFonts.cairo(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .arabiFont
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  fontSize: 22.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .arabiFont
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .radius
                                                .sm),
                                        topRight: Radius.circular(
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .radius
                                                .sm),
                                      ),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .containerBg,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Session',
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
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          FFAppState().sessionCount.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .arabiFont
                                              .override(
                                                font: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .arabiFont
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 22.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .arabiFont
                                                        .fontStyle,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 10.0)),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Remember Allah often for peace of heart.',
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
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
              ].divide(SizedBox(height: 20.0)).around(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
