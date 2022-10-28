import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

//for google sign-in
import 'package:google_sign_in/google_sign_in.dart';

//for apple sign-in
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/controllers/dynamicLinkController.dart';
import 'package:socialchart/controllers/isLoadingController.dart';
import 'package:socialchart/customWidgets/EmailLoginForm.dart';
import 'package:socialchart/customWidgets/SocialLoginButtons.dart';
import 'package:socialchart/customWidgets/TermsOfServiceText.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:url_launcher/url_launcher.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});
  static const routeName = '/ScreenLogin';

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = GlobalKey<ScaffoldState>();
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Container(
                      child: Image.asset(
                    "assets/images/Logo_Light.png",
                    height: 150,
                    fit: BoxFit.scaleDown,
                  )),
                  SizedBox(height: 50),
                  Container(
                    // height: 190,

                    child: EmailLoginForm(),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 60,
                    // alignment: Alignment.bottomCenter,
                    child: Text.rich(TextSpan(text: "뭔가 문제가 있으신가요?", children: [
                      TextSpan(
                        style: TextStyle(color: Colors.blue),
                        text: "👉신고하기 🎉",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              Navigator.pushNamed(context, "/ScreenReport"),
                        // Get.toNamed("/ScreenReport"),
                      ),
                    ])),
                  ),
                  Container(
                    // height: 144,
                    // color: Colors.blue,
                    child: SocialLoginButtons(),
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.amber,
                      child: TermsOfService(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Obx(
          //   () => Offstage(
          //     offstage: !IsLoadingController.to.isLoading.value,
          //     child: const Opacity(
          //       opacity: 0.5,
          //       child: ModalBarrier(dismissible: false, color: Colors.black),
          //     ),
          //   ),
          // ),
          // Obx(
          //   () => Offstage(
          //     offstage: !IsLoadingController.to.isLoading.value,
          //     child: const Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
