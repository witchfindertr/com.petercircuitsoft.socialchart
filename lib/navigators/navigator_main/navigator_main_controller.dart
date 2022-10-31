import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_constant.dart';

class MainNavigatorController extends GetxController {
  var _currentIndex = NavKeys.home.obs;

  NavKeys get currentIndex => _currentIndex.value;
  set currentIndex(NavKeys item) => _currentIndex.value = item;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
