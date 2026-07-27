import '/custom_header_footer/mk_home_page_header/mk_home_page_header_widget.dart';
import '/custom_header_footer/section_header/section_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kanalen/video_card/video_card_widget.dart';
import '/index.dart';
import 'm_kkanalen_widget.dart' show MKkanalenWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class MKkanalenModel extends FlutterFlowModel<MKkanalenWidget> {
  ///  Local state fields for this page.

  bool fullText = true;

  ///  State fields for stateful widgets in this page.

  // Model for MkHomePageHeader component.
  late MkHomePageHeaderModel mkHomePageHeaderModel;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel1;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel2;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel3;
  // Models for VideoRow.
  late FlutterFlowDynamicModels<VideoCardModel> videoRowModels;

  @override
  void initState(BuildContext context) {
    mkHomePageHeaderModel = createModel(context, () => MkHomePageHeaderModel());
    sectionHeaderModel1 = createModel(context, () => SectionHeaderModel());
    sectionHeaderModel2 = createModel(context, () => SectionHeaderModel());
    sectionHeaderModel3 = createModel(context, () => SectionHeaderModel());
    videoRowModels = FlutterFlowDynamicModels(() => VideoCardModel());
  }

  @override
  void dispose() {
    mkHomePageHeaderModel.dispose();
    expandableExpandableController.dispose();
    sectionHeaderModel1.dispose();
    sectionHeaderModel2.dispose();
    sectionHeaderModel3.dispose();
    videoRowModels.dispose();
  }
}
