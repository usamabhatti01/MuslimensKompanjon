import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/custom_header_footer/section_header/section_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home/short_card/short_card_widget.dart';
import '/pages/home/video_row/video_row_widget.dart';
import '/index.dart';
import 'm_kkanalen_widget.dart' show MKkanalenWidget;
import 'package:flutter/material.dart';

class MKkanalenModel extends FlutterFlowModel<MKkanalenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeaderWithIcon component.
  late PageSubHeaderWithIconModel pageSubHeaderWithIconModel;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel1;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel2;
  // Model for ShortCard.
  late ShortCardModel shortCardModel1;
  // Model for ShortCard.
  late ShortCardModel shortCardModel2;
  // Model for ShortCard.
  late ShortCardModel shortCardModel3;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel3;
  // Model for VideoRow.
  late VideoRowModel videoRowModel1;
  // Model for VideoRow.
  late VideoRowModel videoRowModel2;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel4;
  // Model for VideoRow.
  late VideoRowModel videoRowModel3;
  // Model for VideoRow.
  late VideoRowModel videoRowModel4;

  @override
  void initState(BuildContext context) {
    pageSubHeaderWithIconModel =
        createModel(context, () => PageSubHeaderWithIconModel());
    sectionHeaderModel1 = createModel(context, () => SectionHeaderModel());
    sectionHeaderModel2 = createModel(context, () => SectionHeaderModel());
    shortCardModel1 = createModel(context, () => ShortCardModel());
    shortCardModel2 = createModel(context, () => ShortCardModel());
    shortCardModel3 = createModel(context, () => ShortCardModel());
    sectionHeaderModel3 = createModel(context, () => SectionHeaderModel());
    videoRowModel1 = createModel(context, () => VideoRowModel());
    videoRowModel2 = createModel(context, () => VideoRowModel());
    sectionHeaderModel4 = createModel(context, () => SectionHeaderModel());
    videoRowModel3 = createModel(context, () => VideoRowModel());
    videoRowModel4 = createModel(context, () => VideoRowModel());
  }

  @override
  void dispose() {
    pageSubHeaderWithIconModel.dispose();
    sectionHeaderModel1.dispose();
    sectionHeaderModel2.dispose();
    shortCardModel1.dispose();
    shortCardModel2.dispose();
    shortCardModel3.dispose();
    sectionHeaderModel3.dispose();
    videoRowModel1.dispose();
    videoRowModel2.dispose();
    sectionHeaderModel4.dispose();
    videoRowModel3.dispose();
    videoRowModel4.dispose();
  }
}
