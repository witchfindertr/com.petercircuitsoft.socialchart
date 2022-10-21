import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({super.key, required this.emailController});
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 71,
        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          decoration: const InputDecoration(
            helperText: '',
            helperStyle: TextStyle(color: Colors.amber),
            icon: Icon(Icons.email),
            labelText: "이메일",
            hintText: "이메일을 입력해주세요.",
            alignLabelWithHint: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: OutlineInputBorder(
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
