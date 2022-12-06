import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/screens/screen_account_setting/screen_account_setting_controller.dart';

class ScreenAccountSettingBinding extends Bindings {
  final NavKeys? navkey;
  final UserDataModel? userData;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ScreenAccountSettingController>(
        ScreenAccountSettingController(userData: userData),
        tag: navkey?.name);
  }

  ScreenAccountSettingBinding({this.navkey, required this.userData});
}
