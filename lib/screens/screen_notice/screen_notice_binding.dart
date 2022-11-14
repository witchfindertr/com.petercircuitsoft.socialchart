import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_notice/screen_notice_controller.dart';

class ScreenNoticeBinding extends Bindings {
  final NavKeys? navKey;
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenNoticeController>(() => ScreenNoticeController(),
        tag: navKey?.name);
  }

  ScreenNoticeBinding({required this.navKey});
}
