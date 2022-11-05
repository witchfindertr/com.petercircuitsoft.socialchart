import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_login/screen_login_controller.dart';

class ScreenLoginBinding extends Bindings {
  ScreenLoginBinding({this.navKey});
  final NavKeys? navKey;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenLoginController>(() => ScreenLoginController(),
        tag: navKey?.name);
  }
}
