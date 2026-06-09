import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adhkar_all_pages_banner/adhkar_all_pages_banner_widget.dart';
import '/pages/categories/azhkar_quranic_verse/arabic_heading_and_translation/arabic_heading_and_translation_widget.dart';
import '/pages/categories/azhkar_quranic_verse/supplications_dua/supplications_dua_box/supplications_dua_box_widget.dart';
import 'supplications_dua_widget.dart' show SupplicationsDuaWidget;
import 'package:flutter/material.dart';

class SupplicationsDuaModel extends FlutterFlowModel<SupplicationsDuaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // Model for AdhkarAllPagesBanner component.
  late AdhkarAllPagesBannerModel adhkarAllPagesBannerModel;
  // Model for ArabicHeadingAndTranslation component.
  late ArabicHeadingAndTranslationModel arabicHeadingAndTranslationModel;
  // Model for SupplicationsDuaBox component.
  late SupplicationsDuaBoxModel supplicationsDuaBoxModel1;
  // Model for SupplicationsDuaBox component.
  late SupplicationsDuaBoxModel supplicationsDuaBoxModel2;
  // Model for SupplicationsDuaBox component.
  late SupplicationsDuaBoxModel supplicationsDuaBoxModel3;
  // Model for SupplicationsDuaBox component.
  late SupplicationsDuaBoxModel supplicationsDuaBoxModel4;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
    adhkarAllPagesBannerModel =
        createModel(context, () => AdhkarAllPagesBannerModel());
    arabicHeadingAndTranslationModel =
        createModel(context, () => ArabicHeadingAndTranslationModel());
    supplicationsDuaBoxModel1 =
        createModel(context, () => SupplicationsDuaBoxModel());
    supplicationsDuaBoxModel2 =
        createModel(context, () => SupplicationsDuaBoxModel());
    supplicationsDuaBoxModel3 =
        createModel(context, () => SupplicationsDuaBoxModel());
    supplicationsDuaBoxModel4 =
        createModel(context, () => SupplicationsDuaBoxModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    adhkarAllPagesBannerModel.dispose();
    arabicHeadingAndTranslationModel.dispose();
    supplicationsDuaBoxModel1.dispose();
    supplicationsDuaBoxModel2.dispose();
    supplicationsDuaBoxModel3.dispose();
    supplicationsDuaBoxModel4.dispose();
  }
}
