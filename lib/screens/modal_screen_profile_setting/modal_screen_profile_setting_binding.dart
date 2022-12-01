import 'package:get/instance_manager.dart';
import 'package:socialchart/screens/modal_screen_profile_setting/modal_screen_profile_setting_controller.dart';

class ModalScreenProfileSettingBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ModalScreenProfileSettingController());
  }
}
