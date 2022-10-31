import 'package:get/get.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_controller.dart';

class ScreenInsightCardBinding extends Bindings {
  final String tag;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenInsightCardController>(
        () => ScreenInsightCardController(),
        tag: tag);
  }

  ScreenInsightCardBinding({required this.tag});
}
