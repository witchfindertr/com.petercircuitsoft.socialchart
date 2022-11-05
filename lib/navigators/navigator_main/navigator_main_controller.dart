import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';

class MainNavigatorController extends GetxController {
  static MainNavigatorController get to => Get.find();
  var _currentIndex = NavKeys.home.obs;
  var _isBottomTabVisible = true.obs;

  NavKeys get currentIndex => _currentIndex.value;
  set currentIndex(NavKeys item) => _currentIndex.value = item;

  bool get isBottomTabVisible => _isBottomTabVisible.value;
  set isBottomTabVisible(bool visible) => _isBottomTabVisible.value = visible;

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
