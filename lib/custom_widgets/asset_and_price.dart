import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

Color colorUpDn(int price) {
  if (price > 0)
    return Colors.red;
  else if (price < 0)
    return Colors.blue;
  else {
    return Colors.black;
  }
}

class AssetAndPrice extends StatelessWidget {
  AssetAndPrice({required this.text, required this.price, this.color});
  final String text;
  final int price;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text.rich(
        TextSpan(
          text: text,
          children: [
            TextSpan(
              style: TextStyle(color: color),
              text: price.toString(),
            )
          ],
        ),
      ),
    );
  }
}
