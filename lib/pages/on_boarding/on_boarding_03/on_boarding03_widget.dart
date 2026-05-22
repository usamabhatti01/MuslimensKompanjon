import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'on_boarding03_model.dart';
export 'on_boarding03_model.dart';

class OnBoarding03Widget extends StatefulWidget {
  const OnBoarding03Widget({super.key});

  @override
  State<OnBoarding03Widget> createState() => _OnBoarding03WidgetState();
}

class _OnBoarding03WidgetState extends State<OnBoarding03Widget> {
  late OnBoarding03Model _model;

  LatLng? currentUserLocationValue;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnBoarding03Model());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.allResult = await actions.loadCitiesFromAsset(
        null,
      );
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 0.9,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(
                FlutterFlowTheme.of(context).designToken.spacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'zswc8wda' /* Search Location */,
                        ),
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController ??=
                                  FormFieldController<String>(
                                _model.dropDownValue ??=
                                    FFAppState().user.city != ''
                                        ? valueOrDefault<String>(
                                            FFAppState().user.city,
                                            'EmptyString',
                                          )
                                        : '',
                              ),
                              options: _model.allResult != null &&
                                      (_model.allResult)!.isNotEmpty
                                  ? _model.allResult!
                                      .map((e) => valueOrDefault<String>(
                                            e.name,
                                            'EmptyString',
                                          ))
                                      .toList()
                                  : ([]),
                              onChanged: (val) => safeSetState(
                                  () => _model.dropDownValue = val),
                              height: 40.0,
                              searchHintTextStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              searchTextStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'wb3ixwl4' /* Search city...  */,
                              ),
                              searchHintText:
                                  FFLocalizations.of(context).getText(
                                '4wb899h8' /*  */,
                              ),
                              icon: Icon(
                                Icons.search_outlined,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 18.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: Colors.transparent,
                              borderWidth: 0.0,
                              borderRadius: 8.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: true,
                              isMultiSelect: false,
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              currentUserLocationValue =
                                  await getCurrentUserLocation(
                                      defaultLocation: LatLng(0.0, 0.0));
                              _model.singleCity =
                                  await actions.loadCitiesFromAsset(
                                currentUserLocationValue,
                              );
                              if (_model.singleCity?.length == 1) {
                                FFAppState().updateUserStruct(
                                  (e) => e
                                    ..city =
                                        _model.singleCity?.firstOrNull?.name,
                                );
                                safeSetState(() {});
                                safeSetState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      _model.singleCity!.firstOrNull!.name,
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Not Found',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                              }

                              safeSetState(() {});
                            },
                            child: Icon(
                              Icons.gps_fixed,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ),
                        ].divide(SizedBox(width: 20.0)),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          FFAppState().updateUserStruct(
                            (e) => e..city = _model.dropDownValue,
                          );
                          safeSetState(() {});

                          context.pushNamed(OnBoarding04Widget.routeName);
                        },
                        text: FFLocalizations.of(context).getText(
                          '610ohxtp' /* Confirm  */,
                        ),
                        icon: Icon(
                          Icons.arrow_forward_outlined,
                          size: 16.0,
                        ),
                        options: FFButtonOptions(
                          width: 250.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconAlignment: IconAlignment.end,
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
