import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_home/screen_home_controller.dart';

class ScreenHomeBinding extends Bindings {
  ScreenHomeBinding({this.navKey});
  final NavKeys? navKey;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenHomeController>(() => ScreenHomeController(),
        tag: navKey?.name);
  }
}
