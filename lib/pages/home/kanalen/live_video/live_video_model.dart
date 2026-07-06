import '/custom_header_footer/mk_home_page_header/mk_home_page_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'live_video_widget.dart' show LiveVideoWidget;
import 'package:flutter/material.dart';

class LiveVideoModel extends FlutterFlowModel<LiveVideoWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for MkHomePageHeader component.
  late MkHomePageHeaderModel mkHomePageHeaderModel;

  @override
  void initState(BuildContext context) {
    mkHomePageHeaderModel = createModel(context, () => MkHomePageHeaderModel());
  }

  @override
  void dispose() {
    mkHomePageHeaderModel.dispose();
  }
}
