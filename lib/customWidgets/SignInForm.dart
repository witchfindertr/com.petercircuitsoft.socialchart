import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
            TextFormField(
              controller: _emailController,
              autovalidateMode: AutovalidateMode.disabled,
              decoration: InputDecoration(labelText: "이메일"),
              validator: (email) {
                if (email!.isEmpty) {
                  return '이메일을 입력해주세요.';
                }
                if (!RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                    .hasMatch(email)) {
                  return '올바른 이메일을 입력해주세요.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.disabled,
              decoration: InputDecoration(labelText: "비밀번호"),
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
            ),
            TextFormField(
              controller: _passwordConfirmController,
              autovalidateMode: AutovalidateMode.disabled,
              decoration: InputDecoration(labelText: "비밀번호 재입력"),
              obscureText: true,
              validator: (passwordConfirm) {
                if (passwordConfirm != _passwordController.text) {
                  return '비밀번호를 다시 확인해주세요.';
                }
                return null;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AuthController.to
                        .signInWithEmailAndPassword(
                            _emailController.text, _passwordController.text)
                        .then((value) => value!.additionalUserInfo!.isNewUser
                            ? Get.snackbar("계정 생성", "계성이 생성되었습니다.")
                            : null)
                        .catchError((onError) {
                      Get.snackbar("오류", '${onError}');
                    });
                  }
                },
                child: const Text("회원 가입")),
          ]),
        ));
  }
}
