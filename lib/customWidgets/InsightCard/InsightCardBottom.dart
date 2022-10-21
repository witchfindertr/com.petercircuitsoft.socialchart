import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class InsightCardBottom extends StatelessWidget {
  const InsightCardBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.width * 0.05;
    return Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: iconSize,
              splashRadius: iconSize,
              onPressed: () => {},
              icon: Icon(Icons.push_pin_outlined),
            ),
            IconButton(
              iconSize: iconSize,
              splashRadius: iconSize,
              onPressed: () => {},
              icon: Icon(Icons.chat_bubble_outline),
            ),
            IconButton(
              iconSize: iconSize,
              splashRadius: iconSize,
              onPressed: () => {},
              icon: Icon(Icons.share_outlined),
            ),
          ],
        ));
  }
}
