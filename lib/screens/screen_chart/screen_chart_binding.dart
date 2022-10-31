import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/screens/screen_chart/screen_chart_controller.dart';

class ScreenChartBinding extends Bindings {
  ScreenChartBinding({required this.navKey});
  final NavKeys navKey;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenChartController>(() => ScreenChartController(),
        tag: navKey.name);
  }
}
