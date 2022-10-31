import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/email_login_form.dart';
import 'package:socialchart/custom_widgets/social_login_buttons.dart';
import 'package:socialchart/custom_widgets/terms_of_service_text.dart';

import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/screens/screen_login/screen_login_controller.dart';
import 'package:socialchart/screens/screen_report/screen_report.dart';

class ScreenLogin extends GetView<ScreenLoginController> {
  const ScreenLogin({super.key, this.navKey});
  final NavKeys? navKey;
  static const routeName = '/ScreenLogin';

  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

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
                          ..onTap = () => Get.toNamed(ScreenReport.routeName,
                              id: navKey?.index),
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
        ],
      ),
    );
  }
}
