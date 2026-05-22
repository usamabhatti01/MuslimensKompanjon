import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/about_islam/islamic_details_page/islamic_details_page_widget.dart';
import 'about_islam_details_page_widget.dart' show AboutIslamDetailsPageWidget;
import 'package:flutter/material.dart';

class AboutIslamDetailsPageModel
    extends FlutterFlowModel<AboutIslamDetailsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for IslamicDetailsPage component.
  late IslamicDetailsPageModel islamicDetailsPageModel;

  @override
  void initState(BuildContext context) {
    islamicDetailsPageModel =
        createModel(context, () => IslamicDetailsPageModel());
  }

  @override
  void dispose() {
    islamicDetailsPageModel.dispose();
  }
}
