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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
                child: Image.asset("assets/images/Logo_Light.png",
                    height: 180, width: 230, fit: BoxFit.fill)),
            Column(children: [
              Container(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () => print("google"),
                      child: Text("Continue with Google"))),
              Container(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () => print("Apple"),
                      child: Text("Continue with Apple"))),
            ]),
            Container(
                margin: EdgeInsets.all(10),
                child: Text.rich(
                  TextSpan(
                    text: "가입과 로그인을 함으로써 ",
                    children: <TextSpan>[
                      TextSpan(
                        text: "서비스 이용약관",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            final Uri _url =
                                Uri.parse('https://petercircuitsoft.com');

                            launchUrl(_url);
                          },
                      ),
                      TextSpan(
                        text: ", ",
                      ),
                      TextSpan(
                        text: "커뮤니티 이용약관",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            final Uri _url =
                                Uri.parse('https://petercircuitsoft.com');

                            launchUrl(_url);
                          },
                      ),
                      TextSpan(
                        text: "\n그리고 ",
                      ),
                      TextSpan(
                        text: "개인정보 처리방침",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            final Uri _url =
                                Uri.parse('https://petercircuitsoft.com');

                            launchUrl(_url);
                          },
                      ),
                      TextSpan(
                        text: "에 동의합니다.",
                      ),
                    ],
                  ),
                )),
          ])),
    ));
  }
}
