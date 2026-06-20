import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/pages/home/video_action/video_action_widget.dart';
import '/pages/home/video_row3/video_row3_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'senaste_live_model.dart';
export 'senaste_live_model.dart';

class SenasteLiveWidget extends StatefulWidget {
  const SenasteLiveWidget({super.key});

  static String routeName = 'SenasteLive';
  static String routePath = '/senasteLive';

  @override
  State<SenasteLiveWidget> createState() => _SenasteLiveWidgetState();
}

class _SenasteLiveWidgetState extends State<SenasteLiveWidget> {
  late SenasteLiveModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SenasteLiveModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                FlutterFlowTheme.of(context).designToken.spacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.pageSubHeaderWithIconModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PageSubHeaderWithIconWidget(
                    pageName: ' ',
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FlutterFlowVideoPlayer(
                            path:
                                'https://assets.mixkit.co/videos/529/529-720.mp4',
                            videoType: VideoType.network,
                            autoPlay: false,
                            looping: true,
                            showControls: true,
                            allowFullScreen: true,
                            allowPlaybackSpeedMenu: false,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hur man förbättrar sin Salah steg för steg',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                                lineHeight: 1.3,
                                              ),
                                        ),
                                        Text(
                                          '98K visningar • 1 vecka sedan',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                    Text(
                                      'I denna föreläsning går vi igenom praktiska steg för att förbättra koncentrationen i bönen, förstå betydelsen av Salah och stärka relationen till Allah i vardagen.',
                                      maxLines: 3,
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                            lineHeight: 1.5,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          wrapWithModel(
                                            model: _model.videoActionModel1,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: VideoActionWidget(
                                              icon: Icon(
                                                Icons.thumb_up_off_alt_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 18.0,
                                              ),
                                              label: 'Gilla',
                                            ),
                                          ),
                                          wrapWithModel(
                                            model: _model.videoActionModel2,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: VideoActionWidget(
                                              icon: Icon(
                                                Icons.reply_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 18.0,
                                              ),
                                              label: 'Dela',
                                            ),
                                          ),
                                          wrapWithModel(
                                            model: _model.videoActionModel3,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: VideoActionWidget(
                                              icon: Icon(
                                                Icons.bookmark_border_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 18.0,
                                              ),
                                              label: 'Spara',
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Relaterade videor',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
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
                                      lineHeight: 1.4,
                                    ),
                              ),
                              wrapWithModel(
                                model: _model.videoRowModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: VideoRow3Widget(
                                  videoDesc:
                                      'https://assets.mixkit.co/videos/529/529-720.mp4',
                                  meta: '98K visningar • 1 vecka sedan',
                                  title:
                                      'Hur man förbättrar sin Salah steg för steg',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.videoRowModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: VideoRow3Widget(
                                  videoDesc:
                                      'https://assets.mixkit.co/videos/529/529-720.mp4',
                                  meta: '23K visningar • 4 dagar sedan',
                                  title: 'Quranlektion för nybörjare – Del 1',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.videoRowModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: VideoRow3Widget(
                                  videoDesc:
                                      'https://assets.mixkit.co/videos/529/529-720.mp4',
                                  meta: '98K visningar • 1 vecka sedan',
                                  title: 'Dua före sömn och morgonadhkar',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.videoRowModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: VideoRow3Widget(
                                  videoDesc:
                                      'https://assets.mixkit.co/videos/529/529-720.mp4',
                                  meta: '23K visningar • 4 dagar sedan',
                                  title: 'Hur man bygger goda islamiska vanor',
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ].divide(SizedBox(height: 20.0)),
                      ),
                    ),
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
