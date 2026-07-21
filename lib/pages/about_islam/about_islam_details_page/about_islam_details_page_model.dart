import '/backend/schema/structs/index.dart';
import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'about_islam_details_page_widget.dart' show AboutIslamDetailsPageWidget;
import 'package:flutter/material.dart';

class AboutIslamDetailsPageModel
    extends FlutterFlowModel<AboutIslamDetailsPageWidget> {
  ///  Local state fields for this page.

  int pageIndex = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - aboutIslamSingleValue] action in AboutIslamDetailsPage widget.
  OnIslamStruct? aboutIslam;
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
