import 'package:get/get.dart';
import 'package:socialchart/screens/screen_explore/screen_explore_controller.dart';

class ScreenExploreBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenExploreController>(() => ScreenExploreController());
  }
}
