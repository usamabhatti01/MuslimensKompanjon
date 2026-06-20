import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home/video_action/video_action_widget.dart';
import '/pages/home/video_row3/video_row3_widget.dart';
import 'senaste_live_widget.dart' show SenasteLiveWidget;
import 'package:flutter/material.dart';

class SenasteLiveModel extends FlutterFlowModel<SenasteLiveWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeaderWithIcon component.
  late PageSubHeaderWithIconModel pageSubHeaderWithIconModel;
  // Model for VideoAction.
  late VideoActionModel videoActionModel1;
  // Model for VideoAction.
  late VideoActionModel videoActionModel2;
  // Model for VideoAction.
  late VideoActionModel videoActionModel3;
  // Model for VideoRow.
  late VideoRow3Model videoRowModel1;
  // Model for VideoRow.
  late VideoRow3Model videoRowModel2;
  // Model for VideoRow.
  late VideoRow3Model videoRowModel3;
  // Model for VideoRow.
  late VideoRow3Model videoRowModel4;

  @override
  void initState(BuildContext context) {
    pageSubHeaderWithIconModel =
        createModel(context, () => PageSubHeaderWithIconModel());
    videoActionModel1 = createModel(context, () => VideoActionModel());
    videoActionModel2 = createModel(context, () => VideoActionModel());
    videoActionModel3 = createModel(context, () => VideoActionModel());
    videoRowModel1 = createModel(context, () => VideoRow3Model());
    videoRowModel2 = createModel(context, () => VideoRow3Model());
    videoRowModel3 = createModel(context, () => VideoRow3Model());
    videoRowModel4 = createModel(context, () => VideoRow3Model());
  }

  @override
  void dispose() {
    pageSubHeaderWithIconModel.dispose();
    videoActionModel1.dispose();
    videoActionModel2.dispose();
    videoActionModel3.dispose();
    videoRowModel1.dispose();
    videoRowModel2.dispose();
    videoRowModel3.dispose();
    videoRowModel4.dispose();
  }
}
