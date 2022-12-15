import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/screens/screen_login/widgets/email_login_form.dart';
import 'package:socialchart/custom_widgets/social_login_buttons.dart';
import 'package:socialchart/custom_widgets/terms_of_service_text.dart';

import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_login/screen_login_controller.dart';
import 'package:socialchart/screens/screen_report/screen_report.dart';

class ScreenLogin extends GetView<ScreenLoginController> {
  const ScreenLogin({super.key, this.navKey});
  final NavKeys? navKey;
  static const routeName = '/ScreenLogin';

  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  static var safeAreaHeight = Get.context!.mediaQuerySize.height -
      Get.context!.mediaQueryPadding.top -
      Get.context!.mediaQueryPadding.bottom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            // reverse: true,
            SingleChildScrollView(
                child: SizedBox(
          height: safeAreaHeight,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  "assets/images/Logo_Light.png",
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                // height: 190,

                child: EmailLoginForm(),
              ),
              Container(
                // height: 60,
                // alignment: Alignment.bottomCenter,
                child: Text.rich(
                  TextSpan(
                    text: "뭔가 문제가 있으신가요?",
                    children: [
                      TextSpan(
                        style: TextStyle(color: Colors.blue),
                        text: "👉신고하기 🎉",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            FocusScope.of(context).unfocus();
                            Get.toNamed(ScreenReport.routeName,
                                id: navKey?.index);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                // fit: FlexFit.loose,
                // flex: 1,
                // color: Colors.amber,
                // alignment: FractionalOffset.bottomCenter,
                child: SocialLoginButtons(),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: TermsOfService(),
                ),
              ),
            ],
            // ),
          ),
        )),
      ),
    );
  }
}
