import 'package:flutter/material.dart';

//for firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
  runApp(const GetMaterialApp(
    title: 'SocialChart',
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
          StreamBuilder<User?>(
            stream: auth.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return const MainNavigator();
              } else {
                return const LoginNavigator();
              }
            }),
          ),
          Obx(
            () => Offstage(
              offstage: !IsLoadingController.to.isLoading,
              child: const Opacity(
                opacity: 0.5,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            ),
          ),
          Obx(
            () => Offstage(
              offstage: !IsLoadingController.to.isLoading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
