import '/extra/prayer_time_item/prayer_time_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'prayer_time_row_widget.dart' show PrayerTimeRowWidget;
import 'package:flutter/material.dart';

class PrayerTimeRowModel extends FlutterFlowModel<PrayerTimeRowWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for PrayerTimeItem.
  late PrayerTimeItemModel prayerTimeItemModel1;
  // Model for PrayerTimeItem.
  late PrayerTimeItemModel prayerTimeItemModel2;
  // Model for PrayerTimeItem.
  late PrayerTimeItemModel prayerTimeItemModel3;
  // Model for PrayerTimeItem.
  late PrayerTimeItemModel prayerTimeItemModel4;
  // Model for PrayerTimeItem.
  late PrayerTimeItemModel prayerTimeItemModel5;

  @override
  void initState(BuildContext context) {
    prayerTimeItemModel1 = createModel(context, () => PrayerTimeItemModel());
    prayerTimeItemModel2 = createModel(context, () => PrayerTimeItemModel());
    prayerTimeItemModel3 = createModel(context, () => PrayerTimeItemModel());
    prayerTimeItemModel4 = createModel(context, () => PrayerTimeItemModel());
    prayerTimeItemModel5 = createModel(context, () => PrayerTimeItemModel());
  }

  @override
  void dispose() {
    prayerTimeItemModel1.dispose();
    prayerTimeItemModel2.dispose();
    prayerTimeItemModel3.dispose();
    prayerTimeItemModel4.dispose();
    prayerTimeItemModel5.dispose();
  }
}
