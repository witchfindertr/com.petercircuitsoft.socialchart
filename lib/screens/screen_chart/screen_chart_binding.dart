import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_chart/screen_chart_controller.dart';

class ScreenChartBinding extends Bindings {
  ScreenChartBinding({required this.navKey, required this.chartId});
  final NavKeys navKey;
  final String chartId;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenChartController>(
        () => ScreenChartController(chartId: chartId),
        tag: navKey.name);
  }
}
