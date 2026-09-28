import '/backend/schema/structs/index.dart';
import '/custom_header_footer/mk_home_page_header/mk_home_page_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kanalen/reel_home_card/reel_home_card_widget.dart';
import '/index.dart';
import 'm_kkanalen_widget.dart' show MKkanalenWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class MKkanalenModel extends FlutterFlowModel<MKkanalenWidget> {
  ///  Local state fields for this page.

  bool fullText = true;

  String filterValue = 'Latest';

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

  // Model for MkHomePageHeader component.
  late MkHomePageHeaderModel mkHomePageHeaderModel;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Custom Action - searchReels] action in FilterWidget widget.
  List<YoutubeStruct>? sortedVideoList;
  // Models for ShortCard.
  late FlutterFlowDynamicModels<ReelHomeCardModel> shortCardModels1;
  // Stores action output result for [Custom Action - searchReels] action in FilterWidget widget.
  List<YoutubeStruct>? sortedReelsList;
  // Models for ShortCard.
  late FlutterFlowDynamicModels<ReelHomeCardModel> shortCardModels2;

  @override
  void initState(BuildContext context) {
    mkHomePageHeaderModel = createModel(context, () => MkHomePageHeaderModel());
    shortCardModels1 = FlutterFlowDynamicModels(() => ReelHomeCardModel());
    shortCardModels2 = FlutterFlowDynamicModels(() => ReelHomeCardModel());
  }

  @override
  void dispose() {
    mkHomePageHeaderModel.dispose();
    expandableExpandableController.dispose();
    tabBarController?.dispose();
    shortCardModels1.dispose();
    shortCardModels2.dispose();
  }
}
