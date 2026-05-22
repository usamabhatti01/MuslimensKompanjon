import '/flutter_flow/flutter_flow_util.dart';
import '/pages/on_boarding/language_selector/language_selector_widget.dart';
import 'select_language_widget.dart' show SelectLanguageWidget;
import 'package:flutter/material.dart';

class SelectLanguageModel extends FlutterFlowModel<SelectLanguageWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Svenska.
  late LanguageSelectorModel svenskaModel;
  // Model for English.
  late LanguageSelectorModel englishModel;

  @override
  void initState(BuildContext context) {
    svenskaModel = createModel(context, () => LanguageSelectorModel());
    englishModel = createModel(context, () => LanguageSelectorModel());
  }

  @override
  void dispose() {
    svenskaModel.dispose();
    englishModel.dispose();
  }
}
