import 'package:get/get.dart';

class IsLoadingController extends GetxController {
  static IsLoadingController get to => Get.find();

  final isLoading = false.obs;

  void setIsLoading(bool value) => isLoading.value = value;
}
