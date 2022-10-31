import 'package:flutter/material.dart';

class ReportTextFormField extends StatelessWidget {
  const ReportTextFormField({
    super.key,
    required this.textController,
    this.maxLine = 10,
    this.hintMessage,
  });
  final TextEditingController textController;
  final int? maxLine;
  final String? hintMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: textController,
        maxLines: maxLine,
        decoration: InputDecoration(
          helperText: '',
          helperStyle: TextStyle(height: 1),
          hintMaxLines: 2,
          hintText: hintMessage ?? "문제점을 알려주시면 최대한 빨리 고치도록 노력해볼게요.",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "입력된 내용이 없어요.";
          }
          return null;
        },
      ),
    );
  }
}
