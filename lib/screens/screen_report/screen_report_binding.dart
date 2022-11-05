import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_notice/screen_notice_controller.dart';
import 'package:socialchart/screens/screen_report/screen_report_controller.dart';

class ScreenReportBinding extends Bindings {
  ScreenReportBinding({required this.navKey});
  final NavKeys navKey;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenReportController>(() => ScreenReportController(),
        tag: navKey.name);
  }
}
