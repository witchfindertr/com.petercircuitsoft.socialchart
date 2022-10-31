import 'package:get/get.dart';
import 'package:socialchart/screens/screen_home/screen_home_controller.dart';

class ScreenHomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenHomeController>(() => ScreenHomeController());
  }
}
