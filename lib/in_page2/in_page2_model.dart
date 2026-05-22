import '/components/prayer_time_row_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'in_page2_widget.dart' show InPage2Widget;
import 'package:flutter/material.dart';

class InPage2Model extends FlutterFlowModel<InPage2Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Dropdown widget.
  String? dropdownValue1;
  FormFieldController<String>? dropdownValueController1;
  // State field(s) for Dropdown widget.
  String? dropdownValue2;
  FormFieldController<String>? dropdownValueController2;
  // State field(s) for Dropdown widget.
  String? dropdownValue3;
  FormFieldController<String>? dropdownValueController3;
  // Model for PrayerTimeRow.
  late PrayerTimeRowModel prayerTimeRowModel1;
  // Model for PrayerTimeRow.
  late PrayerTimeRowModel prayerTimeRowModel2;
  // Model for PrayerTimeRow.
  late PrayerTimeRowModel prayerTimeRowModel3;
  // Model for PrayerTimeRow.
  late PrayerTimeRowModel prayerTimeRowModel4;
  // Model for PrayerTimeRow.
  late PrayerTimeRowModel prayerTimeRowModel5;
  // Model for PrayerTimeRow.
  late PrayerTimeRowModel prayerTimeRowModel6;
  // Model for PrayerTimeRow.
  late PrayerTimeRowModel prayerTimeRowModel7;

  @override
  void initState(BuildContext context) {
    prayerTimeRowModel1 = createModel(context, () => PrayerTimeRowModel());
    prayerTimeRowModel2 = createModel(context, () => PrayerTimeRowModel());
    prayerTimeRowModel3 = createModel(context, () => PrayerTimeRowModel());
    prayerTimeRowModel4 = createModel(context, () => PrayerTimeRowModel());
    prayerTimeRowModel5 = createModel(context, () => PrayerTimeRowModel());
    prayerTimeRowModel6 = createModel(context, () => PrayerTimeRowModel());
    prayerTimeRowModel7 = createModel(context, () => PrayerTimeRowModel());
  }

  @override
  void dispose() {
    prayerTimeRowModel1.dispose();
    prayerTimeRowModel2.dispose();
    prayerTimeRowModel3.dispose();
    prayerTimeRowModel4.dispose();
    prayerTimeRowModel5.dispose();
    prayerTimeRowModel6.dispose();
    prayerTimeRowModel7.dispose();
  }
}
