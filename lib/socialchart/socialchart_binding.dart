import 'package:get/instance_manager.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/controllers/dynamic_link_controller.dart';
import 'package:socialchart/navigators/navigator_login/navigator_login_controller.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';

class SocialChartBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    //for root controller
    Get.put<SocialChartController>(SocialChartController());

    //for auth
    Get.put<AuthController>(AuthController());
    //for dynamiclink => should be in the root because of deep link login
    Get.put<DynamicLinkController>(DynamicLinkController());

    //for main and login navigator
    Get.put<NavigatorMainController>(NavigatorMainController());
    Get.put<NavigatorLoginController>(NavigatorLoginController());
  }
}
