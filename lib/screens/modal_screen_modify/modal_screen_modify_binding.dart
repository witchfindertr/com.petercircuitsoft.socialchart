import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/screens/modal_screen_modify/modal_screen_modify_controller.dart';

class ModalScreenModifyBinding implements Bindings {
  ModalScreenModifyBinding({
    // this.navKey,
    required this.chartId,
    required this.cardId,
    this.cardData,
  });
  // final NavKeys? navKey;
  final String chartId;
  final String cardId;
  final ModelInsightCard? cardData;
  @override
  void dependencies() {
    Get.put<ModalScreenModifyController>(
      ModalScreenModifyController(
          cardId: cardId, chartId: chartId, cardData: cardData),
      // tag: navKey?.name,
    );
  }
}
