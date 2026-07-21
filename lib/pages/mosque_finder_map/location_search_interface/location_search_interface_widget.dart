import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'location_search_interface_model.dart';
export 'location_search_interface_model.dart';

class LocationSearchInterfaceWidget extends StatefulWidget {
  const LocationSearchInterfaceWidget({
    super.key,
    required this.latlng,
  });

  final LatLng? latlng;

  static String routeName = 'LocationSearchInterface';
  static String routePath = '/locationSearchInterface';

  @override
  State<LocationSearchInterfaceWidget> createState() =>
      _LocationSearchInterfaceWidgetState();
}

class _LocationSearchInterfaceWidgetState
    extends State<LocationSearchInterfaceWidget> {
  late LocationSearchInterfaceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LocationSearchInterfaceModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              child: custom_widgets.GoogleMapWidget(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                initialLocation: widget.latlng,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
