import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';

class MainNavigatorBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MainNavigatorController>(() => MainNavigatorController());
  }
}
