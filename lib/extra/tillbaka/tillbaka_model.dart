import '/extra/tillbaka_component/tillbaka_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'tillbaka_widget.dart' show TillbakaWidget;
import 'package:flutter/material.dart';

class TillbakaModel extends FlutterFlowModel<TillbakaWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Arabisktext.
  late TillbakaComponentModel arabisktextModel;
  // Model for Translitterering.
  late TillbakaComponentModel translittereringModel;
  // Model for versttning.
  late TillbakaComponentModel versttningModel;

  @override
  void initState(BuildContext context) {
    arabisktextModel = createModel(context, () => TillbakaComponentModel());
    translittereringModel =
        createModel(context, () => TillbakaComponentModel());
    versttningModel = createModel(context, () => TillbakaComponentModel());
  }

  @override
  void dispose() {
    arabisktextModel.dispose();
    translittereringModel.dispose();
    versttningModel.dispose();
  }

  /// Action blocks.
  Future switchUpdate(
    BuildContext context, {
    required String? widgetValue,
    required String? switchType,
    Future Function()? action,
  }) async {
    bool? output;

    output = await actions.updateFontApperance(
      widgetValue!,
      switchType!,
    );
    if (!output) {
      await action?.call();
    }
  }
}
