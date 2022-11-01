import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/screens/screen_write/screen_write_controller.dart';

class ScreenWriteBinding implements Bindings {
  ScreenWriteBinding({this.navKey});
  final NavKeys? navKey;
  @override
  void dependencies() {
    Get.put<ScreenWriteController>(ScreenWriteController(), tag: navKey?.name);
  }
}
