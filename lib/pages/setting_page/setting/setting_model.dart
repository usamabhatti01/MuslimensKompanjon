import '/custom_header_footer/page_footer/page_footer_widget.dart';
import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/setting_tab/setting_tab_widget.dart';
import '/pages/setting_page/setting_tab_with_switch/setting_tab_with_switch_widget.dart';
import 'setting_widget.dart' show SettingWidget;
import 'package:flutter/material.dart';

class SettingModel extends FlutterFlowModel<SettingWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeaderWithIcon component.
  late PageSubHeaderWithIconModel pageSubHeaderWithIconModel;
  // Model for SettingTabWithSwitch component.
  late SettingTabWithSwitchModel settingTabWithSwitchModel1;
  // Model for SettingTabWithSwitch component.
  late SettingTabWithSwitchModel settingTabWithSwitchModel2;
  // Model for SettingTabWithSwitch component.
  late SettingTabWithSwitchModel settingTabWithSwitchModel3;
  // Model for SettingTabWithSwitch component.
  late SettingTabWithSwitchModel settingTabWithSwitchModel4;
  // Model for SettingTabWithSwitch component.
  late SettingTabWithSwitchModel settingTabWithSwitchModel5;
  // Model for SettingTab component.
  late SettingTabModel settingTabModel1;
  // Model for SettingTab component.
  late SettingTabModel settingTabModel2;
  // Model for SettingTab component.
  late SettingTabModel settingTabModel3;
  // Model for SettingTab component.
  late SettingTabModel settingTabModel4;
  // Model for PageFooter component.
  late PageFooterModel pageFooterModel;

  @override
  void initState(BuildContext context) {
    pageSubHeaderWithIconModel =
        createModel(context, () => PageSubHeaderWithIconModel());
    settingTabWithSwitchModel1 =
        createModel(context, () => SettingTabWithSwitchModel());
    settingTabWithSwitchModel2 =
        createModel(context, () => SettingTabWithSwitchModel());
    settingTabWithSwitchModel3 =
        createModel(context, () => SettingTabWithSwitchModel());
    settingTabWithSwitchModel4 =
        createModel(context, () => SettingTabWithSwitchModel());
    settingTabWithSwitchModel5 =
        createModel(context, () => SettingTabWithSwitchModel());
    settingTabModel1 = createModel(context, () => SettingTabModel());
    settingTabModel2 = createModel(context, () => SettingTabModel());
    settingTabModel3 = createModel(context, () => SettingTabModel());
    settingTabModel4 = createModel(context, () => SettingTabModel());
    pageFooterModel = createModel(context, () => PageFooterModel());
  }

  @override
  void dispose() {
    pageSubHeaderWithIconModel.dispose();
    settingTabWithSwitchModel1.dispose();
    settingTabWithSwitchModel2.dispose();
    settingTabWithSwitchModel3.dispose();
    settingTabWithSwitchModel4.dispose();
    settingTabWithSwitchModel5.dispose();
    settingTabModel1.dispose();
    settingTabModel2.dispose();
    settingTabModel3.dispose();
    settingTabModel4.dispose();
    pageFooterModel.dispose();
  }
}
