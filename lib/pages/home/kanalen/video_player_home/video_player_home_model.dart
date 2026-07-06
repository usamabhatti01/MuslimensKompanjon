import '/custom_header_footer/mk_home_page_header/mk_home_page_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home/kanalen/video_action/video_action_widget.dart';
import '/index.dart';
import 'video_player_home_widget.dart' show VideoPlayerHomeWidget;
import 'package:flutter/material.dart';

class VideoPlayerHomeModel extends FlutterFlowModel<VideoPlayerHomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for MkHomePageHeader component.
  late MkHomePageHeaderModel mkHomePageHeaderModel;
  // Model for VideoAction.
  late VideoActionModel videoActionModel1;
  // Model for VideoAction.
  late VideoActionModel videoActionModel2;

  @override
  void initState(BuildContext context) {
    mkHomePageHeaderModel = createModel(context, () => MkHomePageHeaderModel());
    videoActionModel1 = createModel(context, () => VideoActionModel());
    videoActionModel2 = createModel(context, () => VideoActionModel());
  }

  @override
  void dispose() {
    mkHomePageHeaderModel.dispose();
    videoActionModel1.dispose();
    videoActionModel2.dispose();
  }
}
