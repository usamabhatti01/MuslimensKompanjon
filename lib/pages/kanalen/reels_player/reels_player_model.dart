import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'reels_player_widget.dart' show ReelsPlayerWidget;
import 'package:flutter/material.dart';

class ReelsPlayerModel extends FlutterFlowModel<ReelsPlayerWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
