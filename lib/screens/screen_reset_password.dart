import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/custom_widgets/reset_password_form.dart';
import 'package:socialchart/custom_widgets/text_and_link.dart';

class ScreenResetPassword extends StatefulWidget {
  const ScreenResetPassword({super.key});
  static const routeName = '/ScreenResetPassword';

  @override
  State<ScreenResetPassword> createState() => _ScreenResetPasswordState();
}

class _ScreenResetPasswordState extends State<ScreenResetPassword> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of((context)).size.height * 0.3,
                alignment: Alignment.center,
                child: Text(
                  "비밀번호 찾기",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                alignment: Alignment.center,
                child: ResetPasswordForm(),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextAndLink(
                          text: "아직 계정이 없으신가요?",
                          linkText: "👉계정만들기",
                          linkFunction: () => Navigator.popAndPushNamed(
                              context, "/ScreenCreateAccount"),
                        ),
                        TextAndLink(
                          text: "비밀번호가 생각났나요?",
                          linkText: "👉로그인",
                          linkFunction: () => Navigator.popUntil(
                              context, (route) => route.isFirst),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
