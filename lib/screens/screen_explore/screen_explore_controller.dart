import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenExploreController extends GetxController {
  var scrollController = ScrollController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    scrollController.dispose();
    super.onClose();
  }
}
