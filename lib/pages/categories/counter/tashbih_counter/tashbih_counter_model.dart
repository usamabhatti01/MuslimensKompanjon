import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'tashbih_counter_widget.dart' show TashbihCounterWidget;
import 'package:flutter/material.dart';

class TashbihCounterModel extends FlutterFlowModel<TashbihCounterWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
  }
}
