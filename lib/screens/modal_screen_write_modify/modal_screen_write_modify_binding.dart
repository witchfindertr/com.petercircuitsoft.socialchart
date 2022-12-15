import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/screens/modal_screen_write_modify/modal_screen_write_modify_controller.dart';

enum WriteModify { write, modify }

class ModalScreenWriteModifyBinding implements Bindings {
  ModalScreenWriteModifyBinding({
    // this.navKey,
    required this.chartId,
    this.cardId,
    this.cardData,
  });
  // final NavKeys? navKey;
  final String chartId;
  final String? cardId;
  final ModelInsightCard? cardData;
  @override
  void dependencies() {
    Get.put<ModalScreenWriteModifyController>(
      ModalScreenWriteModifyController(
          cardId: cardId, chartId: chartId, cardData: cardData),
      // tag: navKey?.name,
    );
  }
}
