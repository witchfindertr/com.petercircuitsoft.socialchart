import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/customWidgets/EmailCreateAccountForm.dart';
import 'package:socialchart/customWidgets/EmailTextFormField.dart';
import 'package:socialchart/customWidgets/ResetPasswordForm.dart';
import 'package:socialchart/customWidgets/TextAndLink.dart';

class ScreenCreateAccount extends StatefulWidget {
  const ScreenCreateAccount({super.key});

  @override
  State<ScreenCreateAccount> createState() => _ScreenCreateAccountState();
}

class _ScreenCreateAccountState extends State<ScreenCreateAccount> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: Text(
                  "계정 만들기",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                alignment: Alignment.center,
                child: EmailCreateAccountForm(),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
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
