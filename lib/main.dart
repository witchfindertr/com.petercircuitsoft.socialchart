import 'package:flutter/material.dart';

//for firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/controllers/dynamicLinkController.dart';
import 'package:socialchart/controllers/isLoadingController.dart';

import 'package:socialchart/navigators/LoginNavigator.dart';
import 'package:socialchart/navigators/MainNavigator.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AuthController authController = Get.put(AuthController());
  DynamicLinkController dynamicLinkController =
      Get.put(DynamicLinkController());
  IsLoadingController isLoadingController = Get.put(IsLoadingController());
  runApp(GetMaterialApp(
    title: 'SocialChart',
    theme: ThemeData(fontFamily: "NotoSansKR"),
    home: SocialChart(),
  ));
}

class SocialChart extends StatelessWidget {
  const SocialChart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AuthController.to.firebaseUser.value != null
                ? const MainNavigator()
                : const LoginNavigator(),
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
