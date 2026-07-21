import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'location_search_interface_widget.dart'
    show LocationSearchInterfaceWidget;
import 'package:flutter/material.dart';

class LocationSearchInterfaceModel
    extends FlutterFlowModel<LocationSearchInterfaceWidget> {
  ///  Local state fields for this page.

  List<MosqueStruct> searchCities = [];
  void addToSearchCities(MosqueStruct item) => searchCities.add(item);
  void removeFromSearchCities(MosqueStruct item) => searchCities.remove(item);
  void removeAtIndexFromSearchCities(int index) => searchCities.removeAt(index);
  void insertAtIndexInSearchCities(int index, MosqueStruct item) =>
      searchCities.insert(index, item);
  void updateSearchCitiesAtIndex(int index, Function(MosqueStruct) updateFn) =>
      searchCities[index] = updateFn(searchCities[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
