import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reel_home_card_model.dart';
export 'reel_home_card_model.dart';

class ReelHomeCardWidget extends StatefulWidget {
  const ReelHomeCardWidget({
    super.key,
    this.imagePath,
    String? title,
    String? views,
  })  : this.title = title ?? 'Påminnelse om sabr och tawakkul',
        this.views = views ?? '12K visningar';

  final String? imagePath;
  final String title;
  final String views;

  @override
  State<ReelHomeCardWidget> createState() => _ReelHomeCardWidgetState();
}

class _ReelHomeCardWidgetState extends State<ReelHomeCardWidget> {
  late ReelHomeCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReelHomeCardModel());

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
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: AspectRatio(
                  aspectRatio: 0.56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(),
                    child: Image.network(
                      widget.imagePath!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 5.0)),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: EdgeInsets.all(
                  FlutterFlowTheme.of(context).designToken.spacing.sm),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.views,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).white,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
