import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:socialchart/screens/screen_test/page_test_controller.dart';

class PageTest extends GetView<PageTestController> {
  const PageTest({super.key, this.controllerTag});
  static const routeName = '/ScreenTest';
  final String? controllerTag;
  @override
  // TODO: implement tag
  String? get tag => controllerTag;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Text(controller.text)),
          ElevatedButton(
              onPressed: () => {controller.text = "Changed!!"},
              child: Text("Change the Text!"))
        ],
      ),
    );
  }
}
