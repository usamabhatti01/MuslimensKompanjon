import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'nearby_mosque_locator_widget.dart' show NearbyMosqueLocatorWidget;
import 'package:flutter/material.dart';

class NearbyMosqueLocatorModel
    extends FlutterFlowModel<NearbyMosqueLocatorWidget> {
  ///  Local state fields for this page.

  List<MosqueStruct> searchCities = [];
  void addToSearchCities(MosqueStruct item) => searchCities.add(item);
  void removeFromSearchCities(MosqueStruct item) => searchCities.remove(item);
  void removeAtIndexFromSearchCities(int index) => searchCities.removeAt(index);
  void insertAtIndexInSearchCities(int index, MosqueStruct item) =>
      searchCities.insert(index, item);
  void updateSearchCitiesAtIndex(int index, Function(MosqueStruct) updateFn) =>
      searchCities[index] = updateFn(searchCities[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - searchCityByName] action in TextField widget.
  List<MosqueStruct>? searchOutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
