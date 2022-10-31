import 'package:get/get.dart';
import 'package:socialchart/screens/screen_write/screen_write_controller.dart';

class ScreenWriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenWriteController>(() => ScreenWriteController());
  }
}
