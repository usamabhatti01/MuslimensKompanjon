import '/backend/schema/structs/index.dart';
import '/custom_header_footer/mk_home_page_header/mk_home_page_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kanalen/reel_home_card/reel_home_card_widget.dart';
import '/index.dart';
import 'reels_home_widget.dart' show ReelsHomeWidget;
import 'package:flutter/material.dart';

class ReelsHomeModel extends FlutterFlowModel<ReelsHomeWidget> {
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

  String filterValue = 'Latest';

  ///  State fields for stateful widgets in this page.

  // Model for MkHomePageHeader component.
  late MkHomePageHeaderModel mkHomePageHeaderModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - searchReels] action in TextField widget.
  List<YoutubeStruct>? searchOutput;
  // Stores action output result for [Custom Action - searchReels] action in Button widget.
  List<YoutubeStruct>? latestOutput;
  // Stores action output result for [Custom Action - searchReels] action in Button widget.
  List<YoutubeStruct>? popularOutput;
  // Stores action output result for [Custom Action - searchReels] action in Button widget.
  List<YoutubeStruct>? oldOutput;
  // Models for ShortCard.
  late FlutterFlowDynamicModels<ReelHomeCardModel> shortCardModels;

  @override
  void initState(BuildContext context) {
    mkHomePageHeaderModel = createModel(context, () => MkHomePageHeaderModel());
    shortCardModels = FlutterFlowDynamicModels(() => ReelHomeCardModel());
  }

  @override
  void dispose() {
    mkHomePageHeaderModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    shortCardModels.dispose();
  }
}
