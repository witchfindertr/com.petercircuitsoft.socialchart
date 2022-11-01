import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';

class ScreenWriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  var key = GlobalKey<FormState>();
  var textController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    print("hello world");
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //hide main navigation bar
    Get.find<MainNavigatorController>().isBottomTabVisible = false;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    //show the main navigation bar again
    Get.find<MainNavigatorController>().isBottomTabVisible = true;
  }
}
