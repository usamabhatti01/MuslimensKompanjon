import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/setting_pages/pages_heading_box/pages_heading_box_widget.dart';
import '/pages/setting_pages/setting_page/setting_tab/setting_tab_widget.dart';
import '/pages/setting_pages/setting_page/setting_tab_with_switch/setting_tab_with_switch_widget.dart';
import '/pages/setting_pages/setting_pages_header/setting_pages_header_widget.dart';
import '/index.dart';
import 'setting_widget.dart' show SettingWidget;
import 'package:flutter/material.dart';

class SettingModel extends FlutterFlowModel<SettingWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SettingPagesHeader component.
  late SettingPagesHeaderModel settingPagesHeaderModel;
  // Model for PagesHeadingBox component.
  late PagesHeadingBoxModel pagesHeadingBoxModel;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // Model for SettingTabWithSwitch component.
  late SettingTabWithSwitchModel settingTabWithSwitchModel1;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for SettingTabWithSwitch component.
  late SettingTabWithSwitchModel settingTabWithSwitchModel2;
  // Model for SettingTab component.
  late SettingTabModel settingTabModel1;
  // Model for SettingTab component.
  late SettingTabModel settingTabModel2;

  @override
  void initState(BuildContext context) {
    settingPagesHeaderModel =
        createModel(context, () => SettingPagesHeaderModel());
    pagesHeadingBoxModel = createModel(context, () => PagesHeadingBoxModel());
    settingTabWithSwitchModel1 =
        createModel(context, () => SettingTabWithSwitchModel());
    settingTabWithSwitchModel2 =
        createModel(context, () => SettingTabWithSwitchModel());
    settingTabModel1 = createModel(context, () => SettingTabModel());
    settingTabModel2 = createModel(context, () => SettingTabModel());
  }

  @override
  void dispose() {
    settingPagesHeaderModel.dispose();
    pagesHeadingBoxModel.dispose();
    settingTabWithSwitchModel1.dispose();
    settingTabWithSwitchModel2.dispose();
    settingTabModel1.dispose();
    settingTabModel2.dispose();
  }
}
