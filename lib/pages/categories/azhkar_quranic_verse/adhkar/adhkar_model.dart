import '/components/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adhkar_all_pages_banner/adhkar_all_pages_banner_widget.dart';
import '/pages/categories/azhkar_quranic_verse/adkha_page_component/adkha_page_component_widget.dart';
import '/index.dart';
import 'adhkar_widget.dart' show AdhkarWidget;
import 'package:flutter/material.dart';

class AdhkarModel extends FlutterFlowModel<AdhkarWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // Model for AdhkarAllPagesBanner component.
  late AdhkarAllPagesBannerModel adhkarAllPagesBannerModel;
  // Model for AdkhaPageComponent component.
  late AdkhaPageComponentModel adkhaPageComponentModel1;
  // Model for AdkhaPageComponent component.
  late AdkhaPageComponentModel adkhaPageComponentModel2;
  // Model for AdkhaPageComponent component.
  late AdkhaPageComponentModel adkhaPageComponentModel3;
  // Model for AdkhaPageComponent component.
  late AdkhaPageComponentModel adkhaPageComponentModel4;
  // Model for AdkhaPageComponent component.
  late AdkhaPageComponentModel adkhaPageComponentModel5;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
    adhkarAllPagesBannerModel =
        createModel(context, () => AdhkarAllPagesBannerModel());
    adkhaPageComponentModel1 =
        createModel(context, () => AdkhaPageComponentModel());
    adkhaPageComponentModel2 =
        createModel(context, () => AdkhaPageComponentModel());
    adkhaPageComponentModel3 =
        createModel(context, () => AdkhaPageComponentModel());
    adkhaPageComponentModel4 =
        createModel(context, () => AdkhaPageComponentModel());
    adkhaPageComponentModel5 =
        createModel(context, () => AdkhaPageComponentModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    adhkarAllPagesBannerModel.dispose();
    adkhaPageComponentModel1.dispose();
    adkhaPageComponentModel2.dispose();
    adkhaPageComponentModel3.dispose();
    adkhaPageComponentModel4.dispose();
    adkhaPageComponentModel5.dispose();
  }
}
