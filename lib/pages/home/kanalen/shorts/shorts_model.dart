import '/backend/schema/structs/index.dart';
import '/custom_header_footer/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'shorts_widget.dart' show ShortsWidget;
import 'package:flutter/material.dart';

class ShortsModel extends FlutterFlowModel<ShortsWidget> {
  ///  Local state fields for this page.

  List<YoutubeStruct> reelSearchValue = [];
  void addToReelSearchValue(YoutubeStruct item) => reelSearchValue.add(item);
  void removeFromReelSearchValue(YoutubeStruct item) =>
      reelSearchValue.remove(item);
  void removeAtIndexFromReelSearchValue(int index) =>
      reelSearchValue.removeAt(index);
  void insertAtIndexInReelSearchValue(int index, YoutubeStruct item) =>
      reelSearchValue.insert(index, item);
  void updateReelSearchValueAtIndex(
          int index, Function(YoutubeStruct) updateFn) =>
      reelSearchValue[index] = updateFn(reelSearchValue[index]);

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
