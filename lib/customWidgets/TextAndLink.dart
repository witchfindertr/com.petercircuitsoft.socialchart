import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class TextAndLink extends StatelessWidget {
  const TextAndLink(
      {super.key,
      required this.text,
      required this.linkText,
      required this.linkFunction});
  final String text;
  final String linkText;
  final Function linkFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text.rich(
        TextSpan(
          text: text,
          children: [
            TextSpan(
                style: TextStyle(color: Colors.blue),
                text: linkText,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    linkFunction();
                  })
          ],
        ),
      ),
    );
  }
}
