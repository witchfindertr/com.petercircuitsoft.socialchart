import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_controller.dart';

class ScreenInsightCardBinding extends Bindings {
  final String cardId;
  final NavKeys? navKey;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenInsightCardController>(
        () => ScreenInsightCardController(cardId: cardId),
        tag: navKey?.name);
  }

  ScreenInsightCardBinding({required this.navKey, required this.cardId});
}
