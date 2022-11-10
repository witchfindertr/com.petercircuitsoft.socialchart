import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_login/navigator_login_controller.dart';

class NavigatorLoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigatorLoginController>(() => NavigatorLoginController());
  }
}
