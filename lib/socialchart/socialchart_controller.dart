import 'package:get/get.dart';

class SocialChartController extends GetxController {
  static SocialChartController get to => Get.find();

  //for full screen loading indicator
  final _showFullScreenLoadingIndicator = false.obs;

  bool get showFullScreenLoadingIndicator =>
      _showFullScreenLoadingIndicator.value;
  set showFullScreenLoadingIndicator(bool value) =>
      _showFullScreenLoadingIndicator.value = value;

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
