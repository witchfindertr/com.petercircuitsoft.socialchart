import 'package:get/get.dart';
import 'package:socialchart/screens/screen_notice/screen_notice_controller.dart';

class ScreenNoticeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ScreenNoticeController>(() => ScreenNoticeController());
  }
}
