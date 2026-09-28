import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'nar_hjartat_detail_widget.dart' show NarHjartatDetailWidget;
import 'package:flutter/material.dart';

class NarHjartatDetailModel extends FlutterFlowModel<NarHjartatDetailWidget> {
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
