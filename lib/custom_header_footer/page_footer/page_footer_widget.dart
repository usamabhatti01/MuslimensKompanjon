import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'page_footer_model.dart';
export 'page_footer_model.dart';

class PageFooterWidget extends StatefulWidget {
  const PageFooterWidget({
    super.key,
    required this.selectedIndex,
  });

  final int? selectedIndex;

  @override
  State<PageFooterWidget> createState() => _PageFooterWidgetState();
}

class _PageFooterWidgetState extends State<PageFooterWidget> {
  late PageFooterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PageFooterModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(5.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              if (getCurrentRoute(context) != '/home') {
                context.pushNamed(
                  HomeWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) {
                        if (widget.selectedIndex == 0) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/Vector_(2).png',
                              height: 20.0,
                              fit: BoxFit.contain,
                            ),
                          );
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/HomeA.png',
                              height: 20.0,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      'Hem',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: widget.selectedIndex == 0
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).footerInActive,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 2.0)),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              if (getCurrentRoute(context) != '/kuranHome') {
                context.pushNamed(
                  KuranHomeWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) {
                        if (widget.selectedIndex == 1) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/Vector_(3).png',
                              height: 20.0,
                              fit: BoxFit.contain,
                            ),
                          );
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/Vector_(4).png',
                              height: 20.0,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      'Koran',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: widget.selectedIndex == 1
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).footerInActive,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 2.0)),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              if (getCurrentRoute(context) != '/adhkar') {
                context.pushNamed(
                  AdhkarWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) {
                        if (widget.selectedIndex == 2) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/line-md_sunny-outline-to-moon-transition.png',
                              height: 22.0,
                              fit: BoxFit.contain,
                            ),
                          );
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/line-md_sunny-outline-to-moon-transition_(1).png',
                              height: 22.0,
                              fit: BoxFit.contain,
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      'Adhkar',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: widget.selectedIndex == 2
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).footerInActive,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              if (getCurrentRoute(context) != '/qiblaFinder') {
                context.pushNamed(
                  QiblaFinderWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (context) {
                        if (widget.selectedIndex == 3) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/Vector_(5).png',
                              height: 20.0,
                              fit: BoxFit.fill,
                            ),
                          );
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/Vector_(1).png',
                              height: 20.0,
                              fit: BoxFit.contain,
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      'Qibla ',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: widget.selectedIndex == 3
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).footerInActive,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 2.0)),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              if (getCurrentRoute(context) != '/setting') {
                context.pushNamed(
                  SettingWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.menu,
                      color: widget.selectedIndex == 4
                          ? FlutterFlowTheme.of(context).primary
                          : FlutterFlowTheme.of(context).footerInActive,
                      size: 20.0,
                    ),
                    Text(
                      'Mer',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: widget.selectedIndex == 4
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).footerInActive,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 2.0)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
