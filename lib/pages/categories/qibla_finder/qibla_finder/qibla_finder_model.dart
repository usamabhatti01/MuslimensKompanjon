import '/components/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'qibla_finder_widget.dart' show QiblaFinderWidget;
import 'package:flutter/material.dart';

class QiblaFinderModel extends FlutterFlowModel<QiblaFinderWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
  }
}
