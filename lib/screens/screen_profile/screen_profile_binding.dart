import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'screen_profile_controller.dart';

class ScreenProfileBinding extends Bindings {
  ScreenProfileBinding({this.navKey, required this.userId});
  final NavKeys? navKey;
  final String userId;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenProfileController>(
        () => ScreenProfileController(userId: userId),
        tag: navKey?.name);
  }
}
