import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'youtube_video_item_model.dart';
export 'youtube_video_item_model.dart';

class YoutubeVideoItemWidget extends StatefulWidget {
  const YoutubeVideoItemWidget({
    super.key,
    this.youtubeLink,
    String? videoTitle,
    String? videoTopic,
  })  : this.videoTitle = videoTitle ?? 'Video title',
        this.videoTopic = videoTopic ?? 'Quran Academy';

  final String? youtubeLink;
  final String videoTitle;
  final String videoTopic;

  @override
  State<YoutubeVideoItemWidget> createState() => _YoutubeVideoItemWidgetState();
}

class _YoutubeVideoItemWidgetState extends State<YoutubeVideoItemWidget> {
  late YoutubeVideoItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => YoutubeVideoItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutterFlowYoutubePlayer(
          url: widget.youtubeLink!,
          autoPlay: false,
          looping: true,
          mute: false,
          showControls: true,
          showFullScreen: true,
          strictRelatedVideos: true,
        ),
        Text(
          widget.videoTitle,
          maxLines: 1,
          style: FlutterFlowTheme.of(context).titleSmall.override(
                font: GoogleFonts.plusJakartaSans(
                  fontWeight:
                      FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          widget.videoTopic,
          maxLines: 1,
          style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.inter(
                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ].divide(SizedBox(height: 3.0)),
    );
  }
}
