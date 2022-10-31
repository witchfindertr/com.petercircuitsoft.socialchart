import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import './ScreenProfileController.dart';

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
