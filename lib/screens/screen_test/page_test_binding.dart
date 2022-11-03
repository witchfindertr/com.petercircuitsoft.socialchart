import "package:get/get.dart";
import 'package:socialchart/screens/screen_test/page_test_controller.dart';

class PageTestBinding extends Bindings {
  PageTestBinding({this.controllerTag});
  final String? controllerTag;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(
      () => PageTestController(),
      tag: controllerTag,
    );
  }
}
