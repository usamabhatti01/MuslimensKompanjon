import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home/kanalen/video_action/video_action_widget.dart';
import '/index.dart';
import 'video_player_home_widget.dart' show VideoPlayerHomeWidget;
import 'package:flutter/material.dart';

class VideoPlayerHomeModel extends FlutterFlowModel<VideoPlayerHomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeaderWithIcon component.
  late PageSubHeaderWithIconModel pageSubHeaderWithIconModel;
  // Model for VideoAction.
  late VideoActionModel videoActionModel1;
  // Model for VideoAction.
  late VideoActionModel videoActionModel2;

  @override
  void initState(BuildContext context) {
    pageSubHeaderWithIconModel =
        createModel(context, () => PageSubHeaderWithIconModel());
    videoActionModel1 = createModel(context, () => VideoActionModel());
    videoActionModel2 = createModel(context, () => VideoActionModel());
  }

  @override
  void dispose() {
    pageSubHeaderWithIconModel.dispose();
    videoActionModel1.dispose();
    videoActionModel2.dispose();
  }
}
