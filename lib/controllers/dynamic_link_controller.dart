import 'package:get/get.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/main.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';

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
      var loading = SocialChartController.to;
      if (firebaseAuth
          .isSignInWithEmailLink(deepLink.value!.link.toString().trim())) {
        loading.showFullScreenLoadingIndicator = true;
        firebaseAuth
            .signInWithEmailLink(
                email: AuthController.to.userEmail.value,
                emailLink: deepLink.value!.link.toString().trim())
            .then((value) {
          loading.showFullScreenLoadingIndicator = false;
        }).catchError((onError) {
          loading.showFullScreenLoadingIndicator = false;
          print(onError);
          Get.snackbar("링크가 유효하지 않습니다.", "로그인 링크를 다시 전송해보세요.");
        });
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
