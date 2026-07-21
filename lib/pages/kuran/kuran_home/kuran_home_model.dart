import '/custom_header_footer/koran_page_sub_header/koran_page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'kuran_home_widget.dart' show KuranHomeWidget;
import 'package:flutter/material.dart';

class KuranHomeModel extends FlutterFlowModel<KuranHomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for KoranPageSubHeader component.
  late KoranPageSubHeaderModel koranPageSubHeaderModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {
    koranPageSubHeaderModel =
        createModel(context, () => KoranPageSubHeaderModel());
  }

  @override
  void dispose() {
    koranPageSubHeaderModel.dispose();
    tabBarController?.dispose();
  }
}
