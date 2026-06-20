import '/custom_header_footer/page_footer/page_footer_widget.dart';
import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adkha_page_component/adkha_page_component_widget.dart';
import '/index.dart';
import 'adhkar_widget.dart' show AdhkarWidget;
import 'package:flutter/material.dart';

class AdhkarModel extends FlutterFlowModel<AdhkarWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeaderWithIcon component.
  late PageSubHeaderWithIconModel pageSubHeaderWithIconModel;
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
  // Model for pageFooter component.
  late PageFooterModel pageFooterModel;

  @override
  void initState(BuildContext context) {
    pageSubHeaderWithIconModel =
        createModel(context, () => PageSubHeaderWithIconModel());
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
    pageFooterModel = createModel(context, () => PageFooterModel());
  }

  @override
  void dispose() {
    pageSubHeaderWithIconModel.dispose();
    adkhaPageComponentModel1.dispose();
    adkhaPageComponentModel2.dispose();
    adkhaPageComponentModel3.dispose();
    adkhaPageComponentModel4.dispose();
    adkhaPageComponentModel5.dispose();
    pageFooterModel.dispose();
  }
}
