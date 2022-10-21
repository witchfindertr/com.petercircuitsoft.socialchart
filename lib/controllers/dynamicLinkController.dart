import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:socialchart/controllers/authController.dart';

FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

class DynamicLinkController extends GetxController {
  static DynamicLinkController get to => Get.find();
  late Rx<PendingDynamicLinkData?> initLink;
  late Rx<PendingDynamicLinkData?> deepLink;

  @override
  void onInit() async {
    // TODO: implement onInit
    deepLink = Rx<PendingDynamicLinkData?>(await dynamicLinks.getInitialLink());
    // deepLink = initLink;
    deepLink.bindStream(dynamicLinks.onLink);
    super.onInit();

    ever(deepLink, (_) {
      if (auth.isSignInWithEmailLink(deepLink.value!.link.toString().trim())) {
        auth.signInWithEmailLink(
            email: AuthController.to.userEmail.value,
            emailLink: deepLink.value!.link.toString().trim());
      } else {
        print("Something wrong!!");
      }
    });
  }

  // void initializeDynamicLink() async {
  //   initLink = Rx<PendingDynamicLinkData?>(await dynamicLinks.getInitialLink());
  //   deepLink = initLink;

  // }
}
