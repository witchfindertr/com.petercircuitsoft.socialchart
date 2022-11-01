import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/controllers/isLoadingController.dart';
import 'package:socialchart/custom_widgets/email_text_formfield.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/screens/screen_login/screen_login_controller.dart';

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
                        FocusScope.of(context).unfocus();
                        if (controller.key.currentState!.validate()) {
                          IsLoadingController.to.setIsLoading(true);
                          AuthController.to
                              .sendCreateAccountLink(
                                  controller.emailController.text.trim())
                              .then((value) {
                            //todo: email local storage에 저장
                            IsLoadingController.to.setIsLoading(false);
                            Get.snackbar(
                                "메일 전송 완료", "입력하신 이메일로 로그인 링크가 전송되었습니다.");
                          }).catchError((onError) {
                            IsLoadingController.to.setIsLoading(false);
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
