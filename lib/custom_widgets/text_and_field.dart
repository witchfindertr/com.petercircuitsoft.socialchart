import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textAndField({
  required String text,
  required TextEditingController controller,
  String? hintText,
  int maxLines = 1,
  int? maxLength,
  String? counterText,
}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          maxLength: maxLength ?? 50,
          autocorrect: false,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: controller,
          decoration: InputDecoration(
            alignLabelWithHint: false,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.blueAccent),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            counterText: counterText,
          ),
        ),
      ],
    ),
  );
}
