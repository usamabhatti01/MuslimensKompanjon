import '/custom_header_footer/mk_home_page_header/mk_home_page_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kanalen/video_action/video_action_widget.dart';
import '/pages/kanalen/video_card/video_card_widget.dart';
import '/index.dart';
import 'video_home_widget.dart' show VideoHomeWidget;
import 'package:flutter/material.dart';

class VideoHomeModel extends FlutterFlowModel<VideoHomeWidget> {
  ///  Local state fields for this page.

  bool test = false;

  ///  State fields for stateful widgets in this page.

  // Model for MkHomePageHeader component.
  late MkHomePageHeaderModel mkHomePageHeaderModel;
  // Model for VideoAction.
  late VideoActionModel videoActionModel1;
  // Model for VideoAction.
  late VideoActionModel videoActionModel2;
  // Models for VideoRow.
  late FlutterFlowDynamicModels<VideoCardModel> videoRowModels;

  @override
  void initState(BuildContext context) {
    mkHomePageHeaderModel = createModel(context, () => MkHomePageHeaderModel());
    videoActionModel1 = createModel(context, () => VideoActionModel());
    videoActionModel2 = createModel(context, () => VideoActionModel());
    videoRowModels = FlutterFlowDynamicModels(() => VideoCardModel());
  }

  @override
  void dispose() {
    mkHomePageHeaderModel.dispose();
    videoActionModel1.dispose();
    videoActionModel2.dispose();
    videoRowModels.dispose();
  }
}
