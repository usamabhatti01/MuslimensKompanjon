import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'tashbih_counter_widget.dart' show TashbihCounterWidget;
import 'package:flutter/material.dart';

class TashbihCounterModel extends FlutterFlowModel<TashbihCounterWidget> {
  ///  Local state fields for this page.

  int counter = 0;

  ///  State fields for stateful widgets in this page.

  // Model for AdhkarHeader component.
  late AdhkarHeaderModel adhkarHeaderModel;

  @override
  void initState(BuildContext context) {
    adhkarHeaderModel = createModel(context, () => AdhkarHeaderModel());
  }

  @override
  void dispose() {
    adhkarHeaderModel.dispose();
  }
}
