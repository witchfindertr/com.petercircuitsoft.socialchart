import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/model_typesense_result.dart';
import 'package:socialchart/models/typesense_search_instance.dart';

class ModalScreenSearchController extends GetxController {
  TextEditingController searchFieldController = TextEditingController();
  TypesenseSearchInstance searchInstance = TypesenseSearchInstance();
  final _chartList = Rx<List<TypesenseDocument>>([]);
  // final _dataSetList = Rxn<List<TypesenseDocument>>([]);

  List<TypesenseDocument> get chartList => _chartList.value;
  // List<TypesenseDocument>? get dataSetList => _dataSetList.value;

  void getSearchResult(String value) async {
    if (value.trim().isEmpty) {
      _chartList.value = [];
      _chartList.value.clear();
      return;
    }
    var result =
        await searchInstance.searchChart(value.trim(), "name,description");

    if (result == null) {
      _chartList.value = [];
      return;
    }
    if (result.isEmpty) {
      _chartList.value = [];
      return;
    }
    _chartList.value = result.map((e) => e.document).toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // searchFieldController.addListener(getSearchResult);
    //   if (searchFieldController.text.trim().length == 0) {
    //     // _chartList.value = null;
    //     // _dataSetList.value = null;
    //     return;
    //   }
    //   searchInstance
    //       .searchChart(searchFieldController.text, "name,description")
    //       .then(
    //         (value) =>
    //             _chartList.value = value?.map((e) => e.document).toList(),
    //       );

    // searchInstance
    //     .searchDatasets(searchFieldController.text, "name,description")
    //     .then(
    //       (value) =>
    //           _dataSetList.value = value?.map((e) => e.document).toList(),
    //     );
    // });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    searchFieldController.dispose();
    super.onClose();
  }
}
