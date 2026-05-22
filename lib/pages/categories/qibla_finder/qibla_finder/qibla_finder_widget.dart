import '/components/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'qibla_finder_model.dart';
export 'qibla_finder_model.dart';

class QiblaFinderWidget extends StatefulWidget {
  const QiblaFinderWidget({super.key});

  static String routeName = 'QiblaFinder';
  static String routePath = '/qiblaFinder';

  @override
  State<QiblaFinderWidget> createState() => _QiblaFinderWidgetState();
}

class _QiblaFinderWidgetState extends State<QiblaFinderWidget> {
  late QiblaFinderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QiblaFinderModel());

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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(
                FlutterFlowTheme.of(context).designToken.spacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                wrapWithModel(
                  model: _model.pageSubHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PageSubHeaderWidget(
                    pageName: 'Qibla Finder',
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  child: custom_widgets.QiblaCompassWidget(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
