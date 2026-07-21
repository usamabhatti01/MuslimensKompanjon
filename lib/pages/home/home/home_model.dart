import '/custom_header_footer/page_footer/page_footer_widget.dart';
import '/custom_header_footer/section_header/section_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/home/youtube_reels_item/youtube_reels_item_widget.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for SectionHeader component.
  late SectionHeaderModel sectionHeaderModel;
  // Models for YoutubeReelsItem dynamic component.
  late FlutterFlowDynamicModels<YoutubeReelsItemModel> youtubeReelsItemModels;
  // Model for PageFooter component.
  late PageFooterModel pageFooterModel;

  @override
  void initState(BuildContext context) {
    sectionHeaderModel = createModel(context, () => SectionHeaderModel());
    youtubeReelsItemModels =
        FlutterFlowDynamicModels(() => YoutubeReelsItemModel());
    pageFooterModel = createModel(context, () => PageFooterModel());
  }

  @override
  void dispose() {
    sectionHeaderModel.dispose();
    youtubeReelsItemModels.dispose();
    pageFooterModel.dispose();
  }
}
