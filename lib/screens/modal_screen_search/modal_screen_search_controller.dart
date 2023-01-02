import 'dart:convert';
import 'dart:developer';

import 'package:elastic_app_search/elastic_app_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/model_typesense_result.dart';
import 'package:socialchart/models/typesense_search_instance.dart';

class ModalScreenSearchController extends GetxController {
  TextEditingController searchFieldController = TextEditingController();

  //elastic search
  final service = ElasticAppSearch(
      endPoint:
          "https://social-chart-search.ent.asia-northeast3.gcp.elastic-cloud.com",
      searchKey: dotenv.env['ELASTIC_APP_SEARCH_KEY']!);

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

  void getElasticSearchResult(String value) async {
    ElasticResponse response = await service
        .engine("chartinfo")
        .query(value.trim())
        // .filter("states", isEqualTo: "California")
        // .filter("world_heritage_site", isEqualTo: true)
        // .resultField("title")
        // .resultField("description", snippetSize: 140)
        .page(1, size: 50)
        .get();
    for (ElasticResult result in response.results) {
      print(result.data);
    }
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
