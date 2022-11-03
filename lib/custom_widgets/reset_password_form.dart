import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/custom_widgets/email_text_formfield.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            EmailTextFormField(emailController: _emailController),
            ElevatedButton(
                onPressed: () => AuthController.to
                        .sendPasswordReset(_emailController.text)
                        .then((value) {
                      if (value) {
                        Get.snackbar(
                            "비밀번호 초기화 링크 메일 전송 완료", "메일에서 링크를 확인하시기 바랍니다.");
                        Navigator.popUntil(context, (route) => route.isFirst);
                      } else {
                        Get.snackbar("에러", "이메일 주소를 확인해주시기 바랍니다.");
                      }
                    }),
                child: Text("비밀번호 초기화"))
          ],
        ),
      ),
    );
  }
}
