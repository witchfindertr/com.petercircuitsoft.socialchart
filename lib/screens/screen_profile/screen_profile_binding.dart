import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'screen_profile_controller.dart';

class ScreenProfileBinding extends Bindings {
  ScreenProfileBinding({required this.navKey});
  final NavKeys navKey;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenProfileController>(() => ScreenProfileController(),
        tag: navKey.name);
  }
}
