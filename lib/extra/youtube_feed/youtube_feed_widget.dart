import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import '/pages/home/youtube_video_item/youtube_video_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'youtube_feed_model.dart';
export 'youtube_feed_model.dart';

class YoutubeFeedWidget extends StatefulWidget {
  const YoutubeFeedWidget({super.key});

  static String routeName = 'YoutubeFeed';
  static String routePath = '/youtubeFeed';

  @override
  State<YoutubeFeedWidget> createState() => _YoutubeFeedWidgetState();
}

class _YoutubeFeedWidgetState extends State<YoutubeFeedWidget> {
  late YoutubeFeedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => YoutubeFeedModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubeFullScreenWrapper(
      child: GestureDetector(
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
                    model: _model.pageSubHeaderModel,
                    updateCallback: () => safeSetState(() {}),
                    child: PageSubHeaderWidget(
                      pageName: 'Youtube Feed',
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 214.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          FlutterFlowTheme.of(context).designToken.radius.md),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).containerBg,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          FlutterFlowTheme.of(context).designToken.spacing.md,
                          FlutterFlowTheme.of(context).designToken.spacing.sm,
                          FlutterFlowTheme.of(context).designToken.spacing.md,
                          FlutterFlowTheme.of(context).designToken.spacing.sm),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'YouTube Feed',
                                style: FlutterFlowTheme.of(context)
                                    .blackBold
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .blackBold
                                            .fontStyle,
                                      ),
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .blackBold
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                'View All',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 200.0,
                                child: wrapWithModel(
                                  model: _model.youtubeVideoItemModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: YoutubeVideoItemWidget(),
                                ),
                              ),
                              Container(
                                height: 200.0,
                                child: wrapWithModel(
                                  model: _model.youtubeVideoItemModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: YoutubeVideoItemWidget(),
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 214.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          FlutterFlowTheme.of(context).designToken.radius.md),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).containerBg,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          FlutterFlowTheme.of(context).designToken.spacing.md,
                          FlutterFlowTheme.of(context).designToken.spacing.sm,
                          FlutterFlowTheme.of(context).designToken.spacing.md,
                          FlutterFlowTheme.of(context).designToken.spacing.sm),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'YouTube Feed',
                                style: FlutterFlowTheme.of(context)
                                    .blackBold
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .blackBold
                                            .fontStyle,
                                      ),
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .blackBold
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                'View All',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 200.0,
                                child: wrapWithModel(
                                  model: _model.youtubeVideoItemModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: YoutubeVideoItemWidget(),
                                ),
                              ),
                              Container(
                                height: 200.0,
                                child: wrapWithModel(
                                  model: _model.youtubeVideoItemModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: YoutubeVideoItemWidget(),
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 214.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          FlutterFlowTheme.of(context).designToken.radius.md),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).containerBg,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          FlutterFlowTheme.of(context).designToken.spacing.md,
                          FlutterFlowTheme.of(context).designToken.spacing.sm,
                          FlutterFlowTheme.of(context).designToken.spacing.md,
                          FlutterFlowTheme.of(context).designToken.spacing.sm),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'YouTube Feed',
                                style: FlutterFlowTheme.of(context)
                                    .blackBold
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .blackBold
                                            .fontStyle,
                                      ),
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .blackBold
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                'View All',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 200.0,
                                child: wrapWithModel(
                                  model: _model.youtubeVideoItemModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: YoutubeVideoItemWidget(),
                                ),
                              ),
                              Container(
                                height: 200.0,
                                child: wrapWithModel(
                                  model: _model.youtubeVideoItemModel6,
                                  updateCallback: () => safeSetState(() {}),
                                  child: YoutubeVideoItemWidget(),
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 25.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
