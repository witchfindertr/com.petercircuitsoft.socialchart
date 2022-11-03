import 'package:get/get.dart';

class PageTestController extends GetxController {
  var _text = "Page Test Text".obs;
  String get text => _text.value;
  set text(String value) => _text.value = value;

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
