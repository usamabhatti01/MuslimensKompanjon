import '/extra/feature_item/feature_item_widget.dart';
import '/extra/social_link/social_link_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'about_page_widget.dart' show AboutPageWidget;
import 'package:flutter/material.dart';

class AboutPageModel extends FlutterFlowModel<AboutPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for FeatureItem.
  late FeatureItemModel featureItemModel1;
  // Model for FeatureItem.
  late FeatureItemModel featureItemModel2;
  // Model for FeatureItem.
  late FeatureItemModel featureItemModel3;
  // Model for FeatureItem.
  late FeatureItemModel featureItemModel4;
  // Model for SocialLink.
  late SocialLinkModel socialLinkModel1;
  // Model for SocialLink.
  late SocialLinkModel socialLinkModel2;
  // Model for SocialLink.
  late SocialLinkModel socialLinkModel3;
  // Model for SocialLink.
  late SocialLinkModel socialLinkModel4;

  @override
  void initState(BuildContext context) {
    featureItemModel1 = createModel(context, () => FeatureItemModel());
    featureItemModel2 = createModel(context, () => FeatureItemModel());
    featureItemModel3 = createModel(context, () => FeatureItemModel());
    featureItemModel4 = createModel(context, () => FeatureItemModel());
    socialLinkModel1 = createModel(context, () => SocialLinkModel());
    socialLinkModel2 = createModel(context, () => SocialLinkModel());
    socialLinkModel3 = createModel(context, () => SocialLinkModel());
    socialLinkModel4 = createModel(context, () => SocialLinkModel());
  }

  @override
  void dispose() {
    featureItemModel1.dispose();
    featureItemModel2.dispose();
    featureItemModel3.dispose();
    featureItemModel4.dispose();
    socialLinkModel1.dispose();
    socialLinkModel2.dispose();
    socialLinkModel3.dispose();
    socialLinkModel4.dispose();
  }
}
