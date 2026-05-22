import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/home/categories_sub_tab/categories_sub_tab_widget.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - loadCitiesFromAsset] action in Home widget.
  List<CityRecordStruct>? cityResult;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for CategoriesSubTab component.
  late CategoriesSubTabModel categoriesSubTabModel1;
  // Model for CategoriesSubTab component.
  late CategoriesSubTabModel categoriesSubTabModel2;
  // Model for CategoriesSubTab component.
  late CategoriesSubTabModel categoriesSubTabModel3;
  // Model for CategoriesSubTab component.
  late CategoriesSubTabModel categoriesSubTabModel4;
  // Model for CategoriesSubTab component.
  late CategoriesSubTabModel categoriesSubTabModel5;
  // Model for CategoriesSubTab component.
  late CategoriesSubTabModel categoriesSubTabModel6;

  @override
  void initState(BuildContext context) {
    categoriesSubTabModel1 =
        createModel(context, () => CategoriesSubTabModel());
    categoriesSubTabModel2 =
        createModel(context, () => CategoriesSubTabModel());
    categoriesSubTabModel3 =
        createModel(context, () => CategoriesSubTabModel());
    categoriesSubTabModel4 =
        createModel(context, () => CategoriesSubTabModel());
    categoriesSubTabModel5 =
        createModel(context, () => CategoriesSubTabModel());
    categoriesSubTabModel6 =
        createModel(context, () => CategoriesSubTabModel());
  }

  @override
  void dispose() {
    categoriesSubTabModel1.dispose();
    categoriesSubTabModel2.dispose();
    categoriesSubTabModel3.dispose();
    categoriesSubTabModel4.dispose();
    categoriesSubTabModel5.dispose();
    categoriesSubTabModel6.dispose();
  }
}
