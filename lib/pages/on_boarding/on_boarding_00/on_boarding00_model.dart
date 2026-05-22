import '/flutter_flow/flutter_flow_util.dart';
import '/pages/on_boarding/language_selector/language_selector_widget.dart';
import '/index.dart';
import 'on_boarding00_widget.dart' show OnBoarding00Widget;
import 'package:flutter/material.dart';

class OnBoarding00Model extends FlutterFlowModel<OnBoarding00Widget> {
  ///  Local state fields for this page.

  bool? phoneDetect;

  ///  State fields for stateful widgets in this page.

  // Model for LanguageSelector component.
  late LanguageSelectorModel languageSelectorModel1;
  // Model for LanguageSelector component.
  late LanguageSelectorModel languageSelectorModel2;

  @override
  void initState(BuildContext context) {
    languageSelectorModel1 =
        createModel(context, () => LanguageSelectorModel());
    languageSelectorModel2 =
        createModel(context, () => LanguageSelectorModel());
  }

  @override
  void dispose() {
    languageSelectorModel1.dispose();
    languageSelectorModel2.dispose();
  }
}
