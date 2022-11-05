import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_write/screen_write_controller.dart';

class ScreenWriteBinding implements Bindings {
  ScreenWriteBinding({this.navKey, required this.chartId});
  final NavKeys? navKey;
  final String chartId;
  @override
  void dependencies() {
    Get.put<ScreenWriteController>(ScreenWriteController(chartId: chartId),
        tag: navKey?.name);
  }
}
