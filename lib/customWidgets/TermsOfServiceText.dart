import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget TermsOfService() {
  return Container(
      margin: EdgeInsets.all(10),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
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
          ))));
}
