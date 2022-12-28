import 'package:get/instance_manager.dart';
import 'package:socialchart/screens/modal_screen_create_chart/modal_screen_create_chart_controller.dart';

class ModalScreenCreateChartBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ModalScreenCreateChartController());
  }
}
