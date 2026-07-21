// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/scheduler.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/url_launcher.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    super.key,
    this.width,
    this.height,
    this.initialLocation,
  });

  final double? width;
  final double? height;
  final LatLng? initialLocation;

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late Completer<google_maps.GoogleMapController> _controller;
  google_maps.GoogleMapController? _mapController;
  google_maps.BitmapDescriptor? _mosqueIcon;

  // Local State Variables for search, suggestions and selections
  MosqueStruct? selectedMosque;
  TextEditingController? textController;
  FocusNode? textFieldFocusNode;
  bool showSuggestions = false;
  List<MosqueStruct> searchCities = [];
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _controller = Completer();
    _initializeMarkerBitmap();

    // Retrieve current user location
    getCurrentUserLocation(
            defaultLocation: const LatLng(59.3293, 18.0686), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));

    textController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          setState(() {
            showSuggestions = textController!.text.isNotEmpty;
          });
        }
      });

    textFieldFocusNode = FocusNode()
      ..addListener(() {
        if (mounted) {
          setState(() {
            showSuggestions =
                textFieldFocusNode!.hasFocus && textController!.text.isNotEmpty;
          });
        }
      });
  }

  @override
  void dispose() {
    textController?.dispose();
    textFieldFocusNode?.dispose();
    super.dispose();
  }

  void _initializeMarkerBitmap() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
        final targetHeight = (40 * devicePixelRatio).toInt();

        final imageProvider = ResizeImage(
          const AssetImage('assets/images/mosqueMaker.png'),
          height: targetHeight,
          policy: ResizeImagePolicy.fit,
          allowUpscaling: true,
        );

        final imageConfiguration = createLocalImageConfiguration(context);
        imageProvider.resolve(imageConfiguration).addListener(
          ImageStreamListener((img, _) async {
            final bytes =
                await img.image.toByteData(format: ui.ImageByteFormat.png);
            if (bytes != null && mounted) {
              setState(() {
                _mosqueIcon = google_maps.BitmapDescriptor.fromBytes(
                  bytes.buffer.asUint8List(),
                );
              });
            }
          }),
        );
      } catch (e) {
        print("Error loading custom mosque marker icon: $e");
      }
    });
  }

  Future<void> _animateToMosque(MosqueStruct mosque) async {
    if (mosque.latitude != null) {
      final controller = await _controller.future;
      await controller.animateCamera(
        google_maps.CameraUpdate.newLatLng(
          google_maps.LatLng(
              mosque.latitude!.latitude, mosque.latitude!.longitude),
        ),
      );
    }
  }

  Set<google_maps.Marker> _buildMarkers() {
    final Set<google_maps.Marker> markers = {};
    final list = FFAppState().mosque;

    for (final mosque in list) {
      if (mosque.latitude == null) continue;

      final markerId = google_maps.MarkerId(mosque.name);
      final position = google_maps.LatLng(
        mosque.latitude!.latitude,
        mosque.latitude!.longitude,
      );

      markers.add(
        google_maps.Marker(
          markerId: markerId,
          position: position,
          icon: _mosqueIcon ?? google_maps.BitmapDescriptor.defaultMarker,
          onTap: () {
            setState(() {
              selectedMosque = mosque;
            });
          },
        ),
      );
    }

    return markers;
  }

  Future<void> _locateUser() async {
    try {
      final userLoc = await getCurrentUserLocation(
        defaultLocation: const LatLng(59.3293, 18.0686),
        cached: true,
      );
      final controller = await _controller.future;
      await controller.animateCamera(
        google_maps.CameraUpdate.newLatLng(
          google_maps.LatLng(userLoc.latitude, userLoc.longitude),
        ),
      );
    } catch (e) {
      print("Could not retrieve user location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeMosque = selectedMosque ??
        (FFAppState().mosque.isNotEmpty ? FFAppState().mosque.first : null);

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: Stack(
        children: [
          // 1. Map View
          google_maps.GoogleMap(
            onMapCreated: (controller) async {
              _mapController = controller;
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
            },
            initialCameraPosition: google_maps.CameraPosition(
              target: widget.initialLocation != null
                  ? google_maps.LatLng(widget.initialLocation!.latitude,
                      widget.initialLocation!.longitude)
                  : const google_maps.LatLng(59.3293, 18.0686),
              zoom: 14.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: true,
            markers: _buildMarkers(),
            onTap: (latLng) {
              textFieldFocusNode?.unfocus();
            },
          ),

          // 2. Custom Locate FAB overlay
          Positioned(
            bottom: 180,
            right: 16,
            child: GestureDetector(
              onTap: _locateUser,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: FlutterFlowTheme.of(context)
                          .accent1
                          .withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.my_location,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24,
                ),
              ),
            ),
          ),

          // 3. Search input header
          Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: PointerInterceptor(
              intercepting: isWeb,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, -0.8),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        width: double.infinity,
                        height: 80.0,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Back button
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                      NearbyMosqueLocatorWidget.routeName);
                                },
                                child: Container(
                                  width: 44.0,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8.0,
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        offset: const Offset(0.0, 2.0),
                                      )
                                    ],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Align(
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.chevron_left_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              // Search input field
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8.0,
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        offset: const Offset(0.0, 2.0),
                                      )
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: textController,
                                    focusNode: textFieldFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      'textController',
                                      const Duration(milliseconds: 500),
                                      () async {
                                        final output =
                                            await actions.searchCityByName(
                                          textController!.text,
                                          FFAppState().mosque.toList(),
                                        );
                                        setState(() {
                                          searchCities = output
                                                  ?.toList()
                                                  .cast<MosqueStruct>() ??
                                              [];
                                        });
                                      },
                                    ),
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: false,
                                      hintText: 'Sök stad eller moské...',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: GoogleFonts.manrope()
                                                .fontFamily,
                                            color: const Color(0xFFA3A3A3),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF056F00),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      suffixIcon: (textController
                                                  ?.text.isNotEmpty ??
                                              false)
                                          ? InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  textController?.clear();
                                                  searchCities = [];
                                                  showSuggestions = false;
                                                });
                                              },
                                              child: Icon(
                                                Icons.clear_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 22.0,
                                              ),
                                            )
                                          : Icon(
                                              Icons.search_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              GoogleFonts.manrope().fontFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Autocomplete dropdown list
          if (showSuggestions && searchCities.isNotEmpty)
            Positioned(
              top: 150,
              left: 68,
              right: 24,
              child: PointerInterceptor(
                intercepting: isWeb,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 250),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shrinkWrap: true,
                      itemCount: searchCities.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      itemBuilder: (context, index) {
                        final mosque = searchCities[index];
                        return ListTile(
                          title: Text(
                            getMosqueName(mosque.name),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                          ),
                          subtitle: Text(
                            getMosqueCity(mosque.name),
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                ),
                          ),
                          leading: Icon(
                            Icons.mosque,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                          onTap: () async {
                            setState(() {
                              selectedMosque = mosque;
                              showSuggestions = false;
                              textController!.text = getMosqueName(mosque.name);
                            });
                            textFieldFocusNode?.unfocus();
                            _animateToMosque(mosque);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

          // 5. Dynamic bottom details card
          if (activeMosque != null)
            Align(
              alignment: const AlignmentDirectional(0.0, 0.9),
              child: PointerInterceptor(
                intercepting: isWeb,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (activeMosque.latitude != null) {
                        final lat = activeMosque.latitude!.latitude;
                        final lng = activeMosque.latitude!.longitude;
                        final url =
                            'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 113.2,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: FlutterFlowTheme.of(context).accent1,
                            offset: const Offset(0.0, -2.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(FlutterFlowTheme.of(context)
                            .designToken
                            .spacing
                            .md),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Left Mosque Icon Container
                            Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/mosque.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            // Middle Text Details
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getMosqueName(activeMosque.name),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily:
                                              GoogleFonts.manrope().fontFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    currentUserLocationValue != null
                                        ? '${getMosqueCity(activeMosque.name)} • ${functions.calculateDistance(currentUserLocationValue!, activeMosque.latitude!)}'
                                        : getMosqueCity(activeMosque.name),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              GoogleFonts.manrope().fontFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 13.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            // Right Action Icons
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // Directions Button
                                InkWell(
                                  onTap: () async {
                                    if (activeMosque.latitude != null) {
                                      final lat =
                                          activeMosque.latitude!.latitude;
                                      final lng =
                                          activeMosque.latitude!.longitude;
                                      final url =
                                          'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
                                      final uri = Uri.parse(url);
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(uri,
                                            mode:
                                                LaunchMode.externalApplication);
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.alt_route_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 28.0,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                // Navigation Button
                                InkWell(
                                  onTap: () async {
                                    context.pushNamed(
                                        NearbyMosqueLocatorWidget.routeName);
                                  },
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Global Helper Functions inside Custom Code namespace
String getMosqueName(String fullName) {
  final parts = fullName.split(',');
  if (parts.length > 1) {
    return parts.sublist(1).join(',').trim();
  }
  return fullName;
}

String getMosqueCity(String fullName) {
  final parts = fullName.split(',');
  if (parts.length > 0) {
    return parts[0].trim();
  }
  return fullName;
}
