import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'habit_checklist_component_model.dart';
export 'habit_checklist_component_model.dart';

class HabitChecklistComponentWidget extends StatefulWidget {
  const HabitChecklistComponentWidget({super.key});

  @override
  State<HabitChecklistComponentWidget> createState() =>
      _HabitChecklistComponentWidgetState();
}

class _HabitChecklistComponentWidgetState
    extends State<HabitChecklistComponentWidget> {
  late HabitChecklistComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HabitChecklistComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      child: custom_widgets.HabitSettingsWidget(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
      ),
    );
  }
}
