import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/model_data_set.dart';
import 'package:typesense/typesense.dart';

class ModalScreenCreateChartController extends GetxController {
  TextEditingController chartNameFieldController = TextEditingController();

  List<ModelDataSet> chartDataList = [];
  String selected = "aaaa";

  final host = InternetAddress.loopbackIPv4.address, protocol = protocol.http;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
