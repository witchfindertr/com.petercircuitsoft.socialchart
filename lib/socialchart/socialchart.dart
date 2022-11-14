import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/navigators/navigator_login/navigator_login.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main.dart';
import 'package:socialchart/screens/screen_home/screen_home.dart';
import 'package:socialchart/screens/screen_home/screen_home_binding.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';

class SocialChart extends GetView<SocialChartController> {
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
              offstage: !controller.showFullScreenLoadingIndicator,
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
