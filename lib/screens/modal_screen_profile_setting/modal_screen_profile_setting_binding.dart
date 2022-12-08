import 'package:get/instance_manager.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/screens/modal_screen_profile_setting/modal_screen_profile_setting_controller.dart';

class ModalScreenProfileSettingBinding extends Bindings {
  final ModelUserData userData;
  final String userId;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ModalScreenProfileSettingController(
        userId: userId, userData: userData));
  }

  ModalScreenProfileSettingBinding(
      {required this.userData, required this.userId});
}
