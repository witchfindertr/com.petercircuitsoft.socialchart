import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/custom_widgets/email_text_formfield.dart';
import 'package:socialchart/custom_widgets/password_text_formfield.dart';

class CreateAccountFormController extends GetxController {}

class EmailCreateAccountForm extends StatefulWidget {
  const EmailCreateAccountForm({super.key});

  @override
  State<EmailCreateAccountForm> createState() => _EmailCreateAccountFormState();
}

class _EmailCreateAccountFormState extends State<EmailCreateAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  final _idValidated = false;

  @override
  Widget build(context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(children: [
            EmailTextFormField(emailController: _emailController),
            PwdTextFormField(passwordController: _passwordController),
            PwdConfirmTextFormField(
              passwordController: _passwordConfirmController,
              confirmPasswordController: _passwordController,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AuthController.to
                        .sendCreateAccountLink(_emailController.text)
                        .then((value) => Get.snackbar(
                            "메일 전송 완료", "입력하신 이메일로 로그인 링크가 전송되었습니다."))
                        .catchError(
                            (onError) => Get.snackbar("오류", '${onError}'));
                    // AuthController.to
                    //     .signInWithEmailAndPassword(
                    //         _emailController.text, _passwordController.text)
                    //     .then((value) => value!.additionalUserInfo!.isNewUser
                    //         ? Get.snackbar("계정 생성", "입력하신 이메일로 확인")
                    //         : null)
                    //     .catchError((onError) {
                    //   Get.snackbar("오류", '${onError}');
                    // });
                  }
                },
                child: const Text("계정 생성")),
          ]),
        ));
  }
}
