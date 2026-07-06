import '/backend/schema/structs/index.dart';
import '/custom_header_footer/mk_home_page_header/mk_home_page_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import '/pages/home/kanalen/video_item_card/video_item_card_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'videor_model.dart';
export 'videor_model.dart';

class VideorWidget extends StatefulWidget {
  const VideorWidget({super.key});

  static String routeName = 'Videor';
  static String routePath = '/videor';

  @override
  State<VideorWidget> createState() => _VideorWidgetState();
}

class _VideorWidgetState extends State<VideorWidget> {
  late VideorModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideorModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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

    return YoutubeFullScreenWrapper(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Padding(
            padding: EdgeInsets.all(
                FlutterFlowTheme.of(context).designToken.spacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                        context.pushNamed(MKkanalenWidget.routeName);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                    ),
                    Expanded(
                      child: wrapWithModel(
                        model: _model.mkHomePageHeaderModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MkHomePageHeaderWidget(
                          pageName: 'Video',
                        ),
                      ),
                    ),
                  ].divide(SizedBox(
                      width: FlutterFlowTheme.of(context)
                          .designToken
                          .spacing
                          .xxl)),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textController',
                            Duration(milliseconds: 2000),
                            () async {
                              _model.searchOutput = await actions.searchReels(
                                FFAppState().youtubeData.toList(),
                                _model.textController.text,
                              );
                              _model.videoSearchValue = _model.videoSearchValue
                                  .toList()
                                  .cast<YoutubeStruct>();
                              safeSetState(() {});

                              safeSetState(() {});
                            },
                          ),
                          autofocus: false,
                          enabled: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            hintText: 'Sök videor...',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            suffixIcon: Icon(
                              FontAwesomeIcons.search,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 12.0,
                            ),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
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
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          enableInteractiveSelection: true,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              final videoList =
                                  (_model.textController.text == ''
                                          ? FFAppState().youtubeData
                                          : _model.videoSearchValue)
                                      .toList();

                              return ListView.separated(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  50.0,
                                ),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: videoList.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 20.0),
                                itemBuilder: (context, videoListIndex) {
                                  final videoListItem =
                                      videoList[videoListIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        VideoPlayerHomeWidget.routeName,
                                        queryParameters: {
                                          'videoLink': serializeParam(
                                            videoListItem.video,
                                            ParamType.String,
                                          ),
                                          'title': serializeParam(
                                            videoListItem.title,
                                            ParamType.String,
                                          ),
                                          'views': serializeParam(
                                            videoListItem.views,
                                            ParamType.String,
                                          ),
                                          'postedDuration': serializeParam(
                                            videoListItem.postDate,
                                            ParamType.DateTime,
                                          ),
                                          'videoDetail': serializeParam(
                                            videoListItem.topic,
                                            ParamType.String,
                                          ),
                                          'likes': serializeParam(
                                            videoListItem.likes,
                                            ParamType.String,
                                          ),
                                          'isFav': serializeParam(
                                            videoListItem.isFav,
                                            ParamType.bool,
                                          ),
                                          'index': serializeParam(
                                            videoListIndex,
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: VideoItemCardWidget(
                                      key: Key(
                                          'Keybh7_${videoListIndex}_of_${videoList.length}'),
                                      videoDesc: videoListItem.video,
                                      views: videoListItem.views,
                                      title: videoListItem.title,
                                      postedDate: videoListItem.postDate!,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ),
              ].divide(SizedBox(height: 20.0)).addToStart(SizedBox(
                  height:
                      FlutterFlowTheme.of(context).designToken.spacing.xxl)),
            ),
          ),
        ),
      ),
    );
  }
}
