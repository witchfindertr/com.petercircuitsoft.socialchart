import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:get/get.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({super.key});
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Container(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          width: 200,
          child: ElevatedButton(
              onPressed: () {
                authController.googleAuthSignIn();
              },
              child: Text("Continue with Google"))),
      Container(
          width: 200,
          child: ElevatedButton(
              onPressed: () => print(authController.errorString),
              child: Text("Continue with Apple"))),
    ])));
  }
}
