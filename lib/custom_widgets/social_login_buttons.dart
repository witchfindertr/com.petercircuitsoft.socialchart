import 'package:flutter/material.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Container(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          width: 200,
          child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                authController.signInWithGoogle();
              },
              child: Text("Continue with Google"))),
      SizedBox(
          width: 200,
          child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                authController.signInWithApple();
              },
              child: Text("Continue with Apple"))),
    ])));
  }
}
