import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class InsightCardBottom extends StatelessWidget {
  const InsightCardBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: 20,
              splashRadius: 20,
              onPressed: () => {},
              icon: Icon(Icons.push_pin_outlined),
            ),
            IconButton(
              iconSize: 20,
              splashRadius: 20,
              onPressed: () => {},
              icon: Icon(Icons.chat_bubble_outline),
            ),
            IconButton(
              iconSize: 20,
              splashRadius: 20,
              onPressed: () => {},
              icon: Icon(Icons.share_outlined),
            ),
          ],
        ));
  }
}
