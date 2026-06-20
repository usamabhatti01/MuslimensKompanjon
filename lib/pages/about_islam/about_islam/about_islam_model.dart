import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'about_islam_widget.dart' show AboutIslamWidget;
import 'package:flutter/material.dart';

class AboutIslamModel extends FlutterFlowModel<AboutIslamWidget> {
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
