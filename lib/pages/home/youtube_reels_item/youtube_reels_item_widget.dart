import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'youtube_reels_item_model.dart';
export 'youtube_reels_item_model.dart';

class YoutubeReelsItemWidget extends StatefulWidget {
  const YoutubeReelsItemWidget({
    super.key,
    this.thumbnail,
    String? videoTitle,
    String? videoTopic,
  })  : this.videoTitle = videoTitle ?? 'Video title',
        this.videoTopic = videoTopic ?? 'Quran Academy';

  final String? thumbnail;
  final String videoTitle;
  final String videoTopic;

  @override
  State<YoutubeReelsItemWidget> createState() => _YoutubeReelsItemWidgetState();
}

class _YoutubeReelsItemWidgetState extends State<YoutubeReelsItemWidget> {
  late YoutubeReelsItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => YoutubeReelsItemModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            widget.thumbnail!,
            width: 180.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
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
        Expanded(
          child: Text(
            widget.videoTopic,
            maxLines: 1,
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodySmall.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ].divide(SizedBox(height: 3.0)),
    );
  }
}
