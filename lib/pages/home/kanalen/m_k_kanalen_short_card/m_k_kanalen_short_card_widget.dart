import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'm_k_kanalen_short_card_model.dart';
export 'm_k_kanalen_short_card_model.dart';

class MKKanalenShortCardWidget extends StatefulWidget {
  const MKKanalenShortCardWidget({
    super.key,
    this.imageDesc,
    String? title,
  }) : this.title = title ?? 'Påminnelse om sabr och tawakkul';

  final String? imageDesc;
  final String title;

  @override
  State<MKKanalenShortCardWidget> createState() =>
      _MKKanalenShortCardWidgetState();
}

class _MKKanalenShortCardWidgetState extends State<MKKanalenShortCardWidget> {
  late MKKanalenShortCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MKKanalenShortCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: 120.0,
        height: 170.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageDesc!,
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 120.0,
              fit: BoxFit.fill,
              alignment: Alignment(0.0, 0.0),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: AutoSizeText(
                  valueOrDefault<String>(
                    widget.title,
                    'Påminnelse om sabr och tawakkul',
                  ),
                  maxLines: 2,
                  minFontSize: FFAppConstants.body.toDouble(),
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        lineHeight: 1.4,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
