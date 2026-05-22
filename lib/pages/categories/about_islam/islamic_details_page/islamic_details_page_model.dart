import '/components/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'islamic_details_page_widget.dart' show IslamicDetailsPageWidget;
import 'package:flutter/material.dart';

class IslamicDetailsPageModel
    extends FlutterFlowModel<IslamicDetailsPageWidget> {
  ///  State fields for stateful widgets in this component.

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
