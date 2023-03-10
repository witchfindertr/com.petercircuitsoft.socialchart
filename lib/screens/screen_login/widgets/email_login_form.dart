import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/custom_widgets/email_text_formfield.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/main.dart';
import 'package:socialchart/screens/screen_login/screen_login_controller.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';

class EmailLoginForm extends StatelessWidget {
  var controller = Get.find<ScreenLoginController>(tag: NavKeys.login.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Form(
          key: controller.key,
          child: Column(
            children: [
              EmailTextFormField(emailController: controller.emailController),
              Container(
                  child: ElevatedButton(
                      onPressed: () {
                        var loading = SocialChartController.to;
                        FocusScope.of(context).unfocus();
                        if (controller.key.currentState!.validate()) {
                          loading.showFullScreenLoadingIndicator = true;
                          AuthController.to
                              .sendCreateAccountLink(
                                  controller.emailController.text.trim())
                              .then((value) {
                            //todo: email local storage에 저장
                            loading.showFullScreenLoadingIndicator = false;
                            Get.snackbar(
                                "메일 전송 완료", "입력하신 이메일로 로그인 링크가 전송되었습니다.");
                          }).catchError((onError) {
                            loading.showFullScreenLoadingIndicator = false;
                            print('Email login error: ${onError.toString()}');
                          });
                        }
                      },
                      child: Text("로그인 링크 전송"))),
            ],
          )),
    );
  }
}
