import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'islamic_details_page_model.dart';
export 'islamic_details_page_model.dart';

class IslamicDetailsPageWidget extends StatefulWidget {
  const IslamicDetailsPageWidget({
    super.key,
    required this.pageHeading,
    required this.imagePath,
    required this.audioPath,
    required this.contentBody,
    required this.contentBody2,
    required this.contentBody3,
    required this.pageName,
  });

  final String? pageHeading;
  final String? imagePath;
  final String? audioPath;
  final String? contentBody;
  final String? contentBody2;
  final String? contentBody3;
  final String? pageName;

  @override
  State<IslamicDetailsPageWidget> createState() =>
      _IslamicDetailsPageWidgetState();
}

class _IslamicDetailsPageWidgetState extends State<IslamicDetailsPageWidget> {
  late IslamicDetailsPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IslamicDetailsPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wrapWithModel(
              model: _model.pageSubHeaderWithIconModel,
              updateCallback: () => safeSetState(() {}),
              child: PageSubHeaderWithIconWidget(
                pageName: valueOrDefault<String>(
                  widget.pageName,
                  'Add Page Name',
                ),
              ),
            ),
            Text(
              widget.pageHeading!,
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).headlineLarge.override(
                    font: GoogleFonts.plusJakartaSans(
                      fontWeight:
                          FlutterFlowTheme.of(context).headlineLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                  ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  FlutterFlowTheme.of(context).designToken.radius.md),
              child: Image.network(
                widget.imagePath!,
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            FlutterFlowAudioPlayer(
              audio: Audio.network(
                widget.audioPath!,
                metas: Metas(
                  title: 'Title',
                ),
              ),
              titleTextStyle: FlutterFlowTheme.of(context).titleLarge.override(
                    font: GoogleFonts.plusJakartaSans(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleLarge.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleLarge.fontStyle,
                  ),
              playbackDurationTextStyle: FlutterFlowTheme.of(context)
                  .labelMedium
                  .override(
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
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              playbackButtonColor: FlutterFlowTheme.of(context).primary,
              activeTrackColor: FlutterFlowTheme.of(context).primary,
              inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
              elevation: 0.0,
              playInBackground: PlayInBackground.disabledRestoreOnForeground,
            ),
            Text(
              widget.contentBody!,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
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
            ),
            Text(
              widget.contentBody2!,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
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
            ),
            Text(
              widget.contentBody3!,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
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
            ),
          ].divide(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
