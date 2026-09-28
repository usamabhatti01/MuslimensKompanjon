import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'qibla_finder_widget.dart' show QiblaFinderWidget;
import 'package:flutter/material.dart';

class QiblaFinderModel extends FlutterFlowModel<QiblaFinderWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeaderWithIcon component.
  late PageSubHeaderWithIconModel pageSubHeaderWithIconModel;

  @override
  void initState(BuildContext context) {
    pageSubHeaderWithIconModel =
        createModel(context, () => PageSubHeaderWithIconModel());
  }

  @override
  void dispose() {
    pageSubHeaderWithIconModel.dispose();
  }
}
