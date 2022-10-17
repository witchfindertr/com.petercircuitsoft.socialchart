import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class InsightCardBottom extends StatelessWidget {
  const InsightCardBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.push_pin_outlined),
            Icon(Icons.chat_bubble_outline),
            Icon(Icons.share_outlined),
          ],
        ));
  }
}
