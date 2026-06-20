import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'short_card_model.dart';
export 'short_card_model.dart';

class ShortCardWidget extends StatefulWidget {
  const ShortCardWidget({
    super.key,
    String? imageDesc,
    String? title,
  })  : this.imageDesc = imageDesc ??
            'https://dimg.dreamflow.cloud/v1/image/blue%20mosque%20at%20sunset',
        this.title = title ?? 'Påminnelse om sabr och tawakkul';

  final String imageDesc;
  final String title;

  @override
  State<ShortCardWidget> createState() => _ShortCardWidgetState();
}

class _ShortCardWidgetState extends State<ShortCardWidget> {
  late ShortCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShortCardModel());
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
            CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 0),
              fadeOutDuration: Duration(milliseconds: 0),
              imageUrl: valueOrDefault<String>(
                widget.imageDesc,
                'https://dimg.dreamflow.cloud/v1/image/blue%20mosque%20at%20sunset',
              ),
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 120.0,
              fit: BoxFit.fill,
              alignment: Alignment(0.0, 0.0),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  valueOrDefault<String>(
                    widget.title,
                    'Påminnelse om sabr och tawakkul',
                  ),
                  maxLines: 2,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
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
