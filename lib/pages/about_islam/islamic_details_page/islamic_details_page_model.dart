import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'islamic_details_page_widget.dart' show IslamicDetailsPageWidget;
import 'package:flutter/material.dart';

class IslamicDetailsPageModel
    extends FlutterFlowModel<IslamicDetailsPageWidget> {
  ///  State fields for stateful widgets in this component.

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
