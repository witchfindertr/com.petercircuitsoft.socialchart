import 'package:get/get.dart';
import 'package:socialchart/screens/modal_screen_search/modal_screen_search_controller.dart';

class ModalScreenSearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModalScreenSearchController>(
        () => ModalScreenSearchController());
  }
}
