import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'social_link_model.dart';
export 'social_link_model.dart';

class SocialLinkWidget extends StatefulWidget {
  const SocialLinkWidget({
    super.key,
    String? platform,
    String? label,
  })  : this.platform =
            platform ?? 'https://cdn.simpleicons.org/github/056f00.svg',
        this.label = label ?? 'Open Source';

  final String platform;
  final String label;

  @override
  State<SocialLinkWidget> createState() => _SocialLinkWidgetState();
}

class _SocialLinkWidgetState extends State<SocialLinkWidget> {
  late SocialLinkModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SocialLinkModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.network(
                valueOrDefault<String>(
                  widget.platform,
                  'https://cdn.simpleicons.org/github/056f00.svg',
                ),
                width: 18.0,
                height: 18.0,
                fit: BoxFit.contain,
              ),
              Text(
                valueOrDefault<String>(
                  widget.label,
                  'Open Source',
                ),
                style: FlutterFlowTheme.of(context).labelLarge.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
            ].divide(SizedBox(width: 8.0)),
          ),
        ),
      ),
    );
  }
}
