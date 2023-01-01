import 'package:get/get.dart';
import 'package:socialchart/screens/modal_screen_follower.dart/modal_screen_follower_controller.dart';

class ModalScreenFollowerBinding implements Bindings {
  const ModalScreenFollowerBinding({
    required this.userId,
  });
  final String userId;
  @override
  void dependencies() {
    Get.lazyPut<ModalScreenFollowerController>(
        () => ModalScreenFollowerController(
              userId: userId,
            ));
  }
}
