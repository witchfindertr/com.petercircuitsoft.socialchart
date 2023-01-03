import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/elastic_search_instance.dart';
import 'package:socialchart/models/model_elastic_search.dart';

class ModalScreenSearchController extends GetxController {
  TextEditingController searchFieldController = TextEditingController();

  //elastic search
  ElasticAppSearchInstance searchInstance = ElasticAppSearchInstance(
    endPoint: dotenv.env['ELASTIC_APP_SEARCH_ENDPOINT']!,
    searchKey: dotenv.env['ELASTIC_APP_SEARCH_KEY']!,
  );

  final _chartList = Rx<List<ModelElasticSearchChartInfo>>([]);

  List<ModelElasticSearchChartInfo> get chartList => _chartList.value;

  void getSearchResult(String value, int pageNumber) async {
    if (value.trim().isEmpty) {
      _chartList.value = [];
      return;
    }
    _chartList.value =
        await searchInstance.searchChartInfo(value.trim(), pageNumber);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    searchFieldController.dispose();
    super.onClose();
  }
}
