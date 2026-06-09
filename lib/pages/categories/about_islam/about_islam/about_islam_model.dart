import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'about_islam_widget.dart' show AboutIslamWidget;
import 'package:flutter/material.dart';

class AboutIslamModel extends FlutterFlowModel<AboutIslamWidget> {
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
