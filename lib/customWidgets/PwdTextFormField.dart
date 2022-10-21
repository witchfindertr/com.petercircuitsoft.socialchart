import 'package:flutter/material.dart';

class PwdTextFormField extends StatelessWidget {
  const PwdTextFormField({super.key, required this.passwordController});
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 71,
        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          controller: passwordController,
          decoration: const InputDecoration(
            helperText: ' ',
            icon: Icon(Icons.lock),
            labelText: "비밀번호",
            hintText: "비밀번호를 입력해주세요.",
            alignLabelWithHint: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
          validator: (password) {
            if (password!.isEmpty) {
              return '비밀번호를 입력해주세요.';
            }
            if (password.length < 5) {
              return '비밀번호가 너무 짧습니다.';
            }
            return null;
          },
        ));
  }
}

class PwdConfirmTextFormField extends StatelessWidget {
  const PwdConfirmTextFormField(
      {super.key,
      required this.passwordController,
      required this.confirmPasswordController});
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 71,
        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          controller: passwordController,
          decoration: const InputDecoration(
            helperText: ' ',
            icon: Icon(Icons.lock),
            labelText: "비밀번호 확인",
            hintText: "비밀번호를 입력해주세요.",
            alignLabelWithHint: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
          validator: (password) {
            if (password != confirmPasswordController.text) {
              return '비밀번호가 틀립니다.';
            }
            return null;
          },
        ));
  }
}
