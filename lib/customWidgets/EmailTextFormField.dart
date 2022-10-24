import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.emailController,
    this.hintMessage,
  });
  final TextEditingController emailController;
  final String? hintMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 71,
        margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          decoration: InputDecoration(
            helperText: '',
            helperStyle: const TextStyle(color: Colors.amber),
            icon: const Icon(Icons.email),
            labelText: "이메일",
            hintText: hintMessage ?? "이메일을 입력해주세요.",
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
        ));
  }
}
