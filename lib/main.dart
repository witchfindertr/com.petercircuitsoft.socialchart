import 'package:flutter/material.dart';

//for firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/controllers/dynamicLinkController.dart';
import 'package:socialchart/controllers/isLoadingController.dart';

import 'package:socialchart/navigators/navigator_login/navigator_login.dart';
import 'package:socialchart/navigators/navigator_login/navigator_login_controller.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //initial get controller injection
  Get.put(AuthController());
  Get.put(DynamicLinkController());
  Get.put(IsLoadingController());
  Get.lazyPut(() => MainNavigatorController());
  Get.lazyPut(() => LoginNavigatorController());
  runApp(
    GetMaterialApp(
      title: 'SocialChart',
      theme: ThemeData(fontFamily: "NotoSansKR"),
      home: SocialChart(),
    ),
  );
}

class SocialChart extends GetMaterialApp {
  const SocialChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(
            () => AuthController.to.firebaseUser.value != null
                ? const NavigatorMain()
                : const NavigatorLogin(),
          ),
          Obx(
            () => Offstage(
              offstage: !IsLoadingController.to.isLoading,
              child: Stack(children: const <Widget>[
                Opacity(
                  opacity: 0.5,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.white60,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
