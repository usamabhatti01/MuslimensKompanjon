import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'about_islam_details_page_widget.dart' show AboutIslamDetailsPageWidget;
import 'package:flutter/material.dart';

class AboutIslamDetailsPageModel
    extends FlutterFlowModel<AboutIslamDetailsPageWidget> {
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
