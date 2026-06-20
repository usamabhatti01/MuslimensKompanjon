import '/custom_header_footer/kalender_page_sub_header/kalender_page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'kalender_widget.dart' show KalenderWidget;
import 'package:flutter/material.dart';

class KalenderModel extends FlutterFlowModel<KalenderWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for KalenderPageSubHeader component.
  late KalenderPageSubHeaderModel kalenderPageSubHeaderModel;

  @override
  void initState(BuildContext context) {
    kalenderPageSubHeaderModel =
        createModel(context, () => KalenderPageSubHeaderModel());
  }

  @override
  void dispose() {
    kalenderPageSubHeaderModel.dispose();
  }
}
