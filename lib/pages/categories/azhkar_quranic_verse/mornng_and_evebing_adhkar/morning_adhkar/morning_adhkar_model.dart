import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adhkar_all_pages_banner/adhkar_all_pages_banner_widget.dart';
import '/pages/categories/azhkar_quranic_verse/mornng_and_evebing_adhkar/adkhar_box/adkhar_box_widget.dart';
import 'morning_adhkar_widget.dart' show MorningAdhkarWidget;
import 'package:flutter/material.dart';

class MorningAdhkarModel extends FlutterFlowModel<MorningAdhkarWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // Model for AdhkarAllPagesBanner component.
  late AdhkarAllPagesBannerModel adhkarAllPagesBannerModel;
  // Model for AdkharBox component.
  late AdkharBoxModel adkharBoxModel1;
  // Model for AdkharBox component.
  late AdkharBoxModel adkharBoxModel2;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
    adhkarAllPagesBannerModel =
        createModel(context, () => AdhkarAllPagesBannerModel());
    adkharBoxModel1 = createModel(context, () => AdkharBoxModel());
    adkharBoxModel2 = createModel(context, () => AdkharBoxModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    adhkarAllPagesBannerModel.dispose();
    adkharBoxModel1.dispose();
    adkharBoxModel2.dispose();
  }
}
