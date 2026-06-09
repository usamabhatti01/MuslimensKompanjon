import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adhkar_all_pages_banner/adhkar_all_pages_banner_widget.dart';
import '/pages/categories/azhkar_quranic_verse/arabic_heading_and_translation/arabic_heading_and_translation_widget.dart';
import '/index.dart';
import 'tasbih_widget.dart' show TasbihWidget;
import 'package:flutter/material.dart';

class TasbihModel extends FlutterFlowModel<TasbihWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // Model for AdhkarAllPagesBanner component.
  late AdhkarAllPagesBannerModel adhkarAllPagesBannerModel;
  // Model for ArabicHeadingAndTranslation component.
  late ArabicHeadingAndTranslationModel arabicHeadingAndTranslationModel;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
    adhkarAllPagesBannerModel =
        createModel(context, () => AdhkarAllPagesBannerModel());
    arabicHeadingAndTranslationModel =
        createModel(context, () => ArabicHeadingAndTranslationModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    adhkarAllPagesBannerModel.dispose();
    arabicHeadingAndTranslationModel.dispose();
  }
}
