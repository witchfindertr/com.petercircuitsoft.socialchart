import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

//for google sign-in
import 'package:google_sign_in/google_sign_in.dart';

//for apple sign-in
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:socialchart/customWidgets/LoginButtons.dart';
import 'package:socialchart/customWidgets/TermsOfServiceText.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:url_launcher/url_launcher.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Column(
      children: [
        Expanded(
            flex: 8,
            child: Container(
                // color: Colors.grey,
                child: Image.asset("assets/images/Logo_Light.png",
                    width: 230, fit: BoxFit.contain))),
        Expanded(
            flex: 2,
            child: Container(
              // color: Colors.blue,
              child: LoginButtons(),
            )),
        Expanded(
            flex: 1,
            child: Container(
                // color: Colors.blue,
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  InkWell(
                    child: Text("Create account using email"),
                    onTap: () =>
                        {Navigator.pushNamed(context, "/ScreenSignin")},
                  )
                ])))),
        Expanded(
            flex: 1,
            child: Container(
              // color: Colors.amber,
              child: TermsOfService(),
            )),
      ],
    ))));
  }
}
