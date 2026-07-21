import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'video_action_model.dart';
export 'video_action_model.dart';

class VideoActionWidget extends StatefulWidget {
  const VideoActionWidget({
    super.key,
    this.icon,
    String? likes,
  }) : this.likes = likes ?? '13.5k';

  final Widget? icon;
  final String likes;

  @override
  State<VideoActionWidget> createState() => _VideoActionWidgetState();
}

class _VideoActionWidgetState extends State<VideoActionWidget> {
  late VideoActionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoActionModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.0,
      height: 35.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).switchColor,
        borderRadius: BorderRadius.circular(16.0),
        shape: BoxShape.rectangle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.icon!,
          AutoSizeText(
            valueOrDefault<String>(
              widget.likes,
              'Gilla',
            ),
            minFontSize: FFAppConstants.body.toDouble(),
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  font: GoogleFonts.manrope(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodySmall.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                  lineHeight: 1.3,
                ),
          ),
        ].divide(SizedBox(width: 8.0)),
      ),
    );
  }
}
