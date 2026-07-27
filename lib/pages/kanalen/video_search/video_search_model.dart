import '/backend/schema/structs/index.dart';
import '/custom_header_footer/mk_home_page_header/mk_home_page_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kanalen/video_search_card/video_search_card_widget.dart';
import '/index.dart';
import 'video_search_widget.dart' show VideoSearchWidget;
import 'package:flutter/material.dart';

class VideoSearchModel extends FlutterFlowModel<VideoSearchWidget> {
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

  // Model for MkHomePageHeader component.
  late MkHomePageHeaderModel mkHomePageHeaderModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - searchReels] action in TextField widget.
  List<YoutubeStruct>? searchOutput;
  // Models for VideoItemCard.
  late FlutterFlowDynamicModels<VideoSearchCardModel> videoItemCardModels;

  @override
  void initState(BuildContext context) {
    mkHomePageHeaderModel = createModel(context, () => MkHomePageHeaderModel());
    videoItemCardModels =
        FlutterFlowDynamicModels(() => VideoSearchCardModel());
  }

  @override
  void dispose() {
    mkHomePageHeaderModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    videoItemCardModels.dispose();
  }
}
