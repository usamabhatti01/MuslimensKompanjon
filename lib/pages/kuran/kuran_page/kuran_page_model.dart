import '/custom_header_footer/koran_page_sub_header/koran_page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'kuran_page_widget.dart' show KuranPageWidget;
import 'package:flutter/material.dart';

class KuranPageModel extends FlutterFlowModel<KuranPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for KoranPageSubHeader component.
  late KoranPageSubHeaderModel koranPageSubHeaderModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {
    koranPageSubHeaderModel =
        createModel(context, () => KoranPageSubHeaderModel());
  }

  @override
  void dispose() {
    koranPageSubHeaderModel.dispose();
  }
}
