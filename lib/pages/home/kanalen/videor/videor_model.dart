import '/backend/schema/structs/index.dart';
import '/custom_header_footer/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'videor_widget.dart' show VideorWidget;
import 'package:flutter/material.dart';

class VideorModel extends FlutterFlowModel<VideorWidget> {
  ///  Local state fields for this page.

  List<YoutubeStruct> videoSearchValue = [];
  void addToVideoSearchValue(YoutubeStruct item) => videoSearchValue.add(item);
  void removeFromVideoSearchValue(YoutubeStruct item) =>
      videoSearchValue.remove(item);
  void removeAtIndexFromVideoSearchValue(int index) =>
      videoSearchValue.removeAt(index);
  void insertAtIndexInVideoSearchValue(int index, YoutubeStruct item) =>
      videoSearchValue.insert(index, item);
  void updateVideoSearchValueAtIndex(
          int index, Function(YoutubeStruct) updateFn) =>
      videoSearchValue[index] = updateFn(videoSearchValue[index]);

  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - searchReels] action in TextField widget.
  List<YoutubeStruct>? searchOutput;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
