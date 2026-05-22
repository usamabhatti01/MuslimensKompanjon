import '/components/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home/youtube_video_item/youtube_video_item_widget.dart';
import 'youtube_feed_widget.dart' show YoutubeFeedWidget;
import 'package:flutter/material.dart';

class YoutubeFeedModel extends FlutterFlowModel<YoutubeFeedWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // Model for YoutubeVideoItem component.
  late YoutubeVideoItemModel youtubeVideoItemModel1;
  // Model for YoutubeVideoItem component.
  late YoutubeVideoItemModel youtubeVideoItemModel2;
  // Model for YoutubeVideoItem component.
  late YoutubeVideoItemModel youtubeVideoItemModel3;
  // Model for YoutubeVideoItem component.
  late YoutubeVideoItemModel youtubeVideoItemModel4;
  // Model for YoutubeVideoItem component.
  late YoutubeVideoItemModel youtubeVideoItemModel5;
  // Model for YoutubeVideoItem component.
  late YoutubeVideoItemModel youtubeVideoItemModel6;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
    youtubeVideoItemModel1 =
        createModel(context, () => YoutubeVideoItemModel());
    youtubeVideoItemModel2 =
        createModel(context, () => YoutubeVideoItemModel());
    youtubeVideoItemModel3 =
        createModel(context, () => YoutubeVideoItemModel());
    youtubeVideoItemModel4 =
        createModel(context, () => YoutubeVideoItemModel());
    youtubeVideoItemModel5 =
        createModel(context, () => YoutubeVideoItemModel());
    youtubeVideoItemModel6 =
        createModel(context, () => YoutubeVideoItemModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    youtubeVideoItemModel1.dispose();
    youtubeVideoItemModel2.dispose();
    youtubeVideoItemModel3.dispose();
    youtubeVideoItemModel4.dispose();
    youtubeVideoItemModel5.dispose();
    youtubeVideoItemModel6.dispose();
  }
}
