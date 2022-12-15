import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Container(
      width: 270,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialLoginButton(
              buttonType: SocialLoginButtonType.google,
              onPressed: () {
                FocusScope.of(context).unfocus();
                authController.signInWithGoogle();
              },
            ),
            SizedBox(
              height: 10,
            ),
            // child: ElevatedButton(
            //     onPressed: () {
            //       FocusScope.of(context).unfocus();
            //       authController.signInWithGoogle();
            //     },
            //     child: Text("Continue with Google"))),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.apple,
              onPressed: () {
                FocusScope.of(context).unfocus();
                authController.signInWithApple();
              },
            ),
          ],
        ),
      ),
    );
  }
}
