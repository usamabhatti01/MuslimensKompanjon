import '/custom_header_footer/page_sub_header/page_sub_header_widget.dart';
import '/extra/search_bar/search_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home/video_item_card/video_item_card_widget.dart';
import '/index.dart';
import 'videor_widget.dart' show VideorWidget;
import 'package:flutter/material.dart';

class VideorModel extends FlutterFlowModel<VideorWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // Model for searchBar component.
  late SearchBarModel searchBarModel;
  // Model for VideoItemCard.
  late VideoItemCardModel videoItemCardModel1;
  // Model for VideoItemCard.
  late VideoItemCardModel videoItemCardModel2;
  // Model for VideoItemCard.
  late VideoItemCardModel videoItemCardModel3;
  // Model for VideoItemCard.
  late VideoItemCardModel videoItemCardModel4;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
    searchBarModel = createModel(context, () => SearchBarModel());
    videoItemCardModel1 = createModel(context, () => VideoItemCardModel());
    videoItemCardModel2 = createModel(context, () => VideoItemCardModel());
    videoItemCardModel3 = createModel(context, () => VideoItemCardModel());
    videoItemCardModel4 = createModel(context, () => VideoItemCardModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    searchBarModel.dispose();
    videoItemCardModel1.dispose();
    videoItemCardModel2.dispose();
    videoItemCardModel3.dispose();
    videoItemCardModel4.dispose();
  }
}
