import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'rating_star_model.dart';
export 'rating_star_model.dart';

class RatingStarWidget extends StatefulWidget {
  const RatingStarWidget({
    super.key,
    bool? isFilled,
    double? size,
  })  : this.isFilled = isFilled ?? true,
        this.size = size ?? 40.0;

  final bool isFilled;
  final double size;

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

class _RatingStarWidgetState extends State<RatingStarWidget> {
  late RatingStarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RatingStarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      child: Stack(
        alignment: AlignmentDirectional(0.0, 0.0),
        children: [
          if (widget.isFilled ? true : false)
            Icon(
              Icons.star_rounded,
              color: widget.isFilled
                  ? FlutterFlowTheme.of(context).warning
                  : FlutterFlowTheme.of(context).accent3,
              size: valueOrDefault<double>(
                widget.size,
                40.0,
              ),
            ),
          if (widget.isFilled ? false : true)
            Icon(
              Icons.star_outline_rounded,
              color: widget.isFilled
                  ? FlutterFlowTheme.of(context).warning
                  : FlutterFlowTheme.of(context).accent3,
              size: valueOrDefault<double>(
                widget.size,
                40.0,
              ),
            ),
        ],
      ),
    );
  }
}
