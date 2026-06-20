import '/custom_header_footer/page_sub_header/page_sub_header_widget.dart';
import '/extra/search_bar/search_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home/short_card2/short_card2_widget.dart';
import '/index.dart';
import 'shorts_widget.dart' show ShortsWidget;
import 'package:flutter/material.dart';

class ShortsModel extends FlutterFlowModel<ShortsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // Model for searchBar component.
  late SearchBarModel searchBarModel;
  // Model for ShortCard.
  late ShortCard2Model shortCardModel1;
  // Model for ShortCard.
  late ShortCard2Model shortCardModel2;
  // Model for ShortCard.
  late ShortCard2Model shortCardModel3;
  // Model for ShortCard.
  late ShortCard2Model shortCardModel4;
  // Model for ShortCard.
  late ShortCard2Model shortCardModel5;
  // Model for ShortCard.
  late ShortCard2Model shortCardModel6;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
    searchBarModel = createModel(context, () => SearchBarModel());
    shortCardModel1 = createModel(context, () => ShortCard2Model());
    shortCardModel2 = createModel(context, () => ShortCard2Model());
    shortCardModel3 = createModel(context, () => ShortCard2Model());
    shortCardModel4 = createModel(context, () => ShortCard2Model());
    shortCardModel5 = createModel(context, () => ShortCard2Model());
    shortCardModel6 = createModel(context, () => ShortCard2Model());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    searchBarModel.dispose();
    shortCardModel1.dispose();
    shortCardModel2.dispose();
    shortCardModel3.dispose();
    shortCardModel4.dispose();
    shortCardModel5.dispose();
    shortCardModel6.dispose();
  }
}
