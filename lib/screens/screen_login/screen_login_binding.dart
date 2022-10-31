import 'package:get/get.dart';
import 'package:socialchart/screens/screen_login/screen_login_controller.dart';

class ScreenLoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenLoginController>(() => ScreenLoginController());
  }
}
