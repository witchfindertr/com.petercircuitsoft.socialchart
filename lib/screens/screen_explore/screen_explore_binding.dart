import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_explore/screen_explore_controller.dart';

class ScreenExploreBinding extends Bindings {
  ScreenExploreBinding({this.navKey});
  final NavKeys? navKey;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenExploreController>(() => ScreenExploreController(),
        tag: navKey?.name);
  }
}
