import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
                padding: EdgeInsets.zero,
                child: Image.asset(
                  isDark
                      ? "assets/images/social_login_buttons/apple_dark.png"
                      : "assets/images/social_login_buttons/apple_light.png",
                ),
                onPressed: () {
                  authController.signInWithApple();
                }),
            SizedBox(
              height: 10,
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Image.asset(
                isDark
                    ? "assets/images/social_login_buttons/google_dark.png"
                    : "assets/images/social_login_buttons/google_light.png",
              ),
              onPressed: () {
                authController.signInWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
