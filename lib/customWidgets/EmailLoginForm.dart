import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/controllers/isLoadingController.dart';
import 'package:socialchart/customWidgets/EmailTextFormField.dart';
import 'package:socialchart/customWidgets/PwdTextFormField.dart';
import 'package:socialchart/customWidgets/TextAndLink.dart';

class EmailLoginForm extends StatefulWidget {
  const EmailLoginForm({super.key});

  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              EmailTextFormField(emailController: _emailController),
              // PwdTextFormField(passwordController: _passwordController),
              // TextAndLink(
              //     text: "비밀번호가 생각나지 않으세요?",
              //     linkText: "👉비밀번호 초기화",
              //     linkFunction: () =>
              //         Navigator.pushNamed(context, "/ScreenResetPassword")),
              Container(
                  // width: double.infinity,
                  // color: Colors.amber,
                  // margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          IsLoadingController.to.setIsLoading(true);
                          AuthController.to
                              .sendCreateAccountLink(
                                  _emailController.text.trim())
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
