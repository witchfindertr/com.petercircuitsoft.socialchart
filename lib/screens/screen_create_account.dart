import 'package:flutter/material.dart';
import 'package:socialchart/custom_widgets/email_create_account_form.dart';
import 'package:socialchart/custom_widgets/text_and_link.dart';

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
