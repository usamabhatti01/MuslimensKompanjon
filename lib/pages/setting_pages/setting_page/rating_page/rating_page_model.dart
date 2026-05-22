import '/components/feedback_chip_widget.dart';
import '/components/rating_star_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'rating_page_widget.dart' show RatingPageWidget;
import 'package:flutter/material.dart';

class RatingPageModel extends FlutterFlowModel<RatingPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for RatingStar.
  late RatingStarModel ratingStarModel1;
  // Model for RatingStar.
  late RatingStarModel ratingStarModel2;
  // Model for RatingStar.
  late RatingStarModel ratingStarModel3;
  // Model for RatingStar.
  late RatingStarModel ratingStarModel4;
  // Model for RatingStar.
  late RatingStarModel ratingStarModel5;
  // Model for FeedbackChip.
  late FeedbackChipModel feedbackChipModel1;
  // Model for FeedbackChip.
  late FeedbackChipModel feedbackChipModel2;
  // Model for FeedbackChip.
  late FeedbackChipModel feedbackChipModel3;
  // Model for FeedbackChip.
  late FeedbackChipModel feedbackChipModel4;
  // Model for FeedbackChip.
  late FeedbackChipModel feedbackChipModel5;
  // Model for FeedbackChip.
  late FeedbackChipModel feedbackChipModel6;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    ratingStarModel1 = createModel(context, () => RatingStarModel());
    ratingStarModel2 = createModel(context, () => RatingStarModel());
    ratingStarModel3 = createModel(context, () => RatingStarModel());
    ratingStarModel4 = createModel(context, () => RatingStarModel());
    ratingStarModel5 = createModel(context, () => RatingStarModel());
    feedbackChipModel1 = createModel(context, () => FeedbackChipModel());
    feedbackChipModel2 = createModel(context, () => FeedbackChipModel());
    feedbackChipModel3 = createModel(context, () => FeedbackChipModel());
    feedbackChipModel4 = createModel(context, () => FeedbackChipModel());
    feedbackChipModel5 = createModel(context, () => FeedbackChipModel());
    feedbackChipModel6 = createModel(context, () => FeedbackChipModel());
  }

  @override
  void dispose() {
    ratingStarModel1.dispose();
    ratingStarModel2.dispose();
    ratingStarModel3.dispose();
    ratingStarModel4.dispose();
    ratingStarModel5.dispose();
    feedbackChipModel1.dispose();
    feedbackChipModel2.dispose();
    feedbackChipModel3.dispose();
    feedbackChipModel4.dispose();
    feedbackChipModel5.dispose();
    feedbackChipModel6.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
