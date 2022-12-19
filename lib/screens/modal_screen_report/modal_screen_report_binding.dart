import 'package:get/get.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/screens/modal_screen_report/modal_screen_report_controller.dart';

class ModalScreenReportBinding implements Bindings {
  ModalScreenReportBinding({
    required this.cardId,
  });
  // final NavKeys? navKey;
  final String cardId;
  @override
  void dependencies() {
    Get.put<ModalScreenReportController>(
      ModalScreenReportController(cardId: cardId),
      // tag: navKey?.name,
    );
  }
}
